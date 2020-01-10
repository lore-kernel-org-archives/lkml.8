Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC668C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25372064C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgAJHuw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:50:52 -0500
Received: from mailhub2.otago.ac.nz ([139.80.64.247]:58736 "EHLO
        mailhub2.otago.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgAJHuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:50:52 -0500
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2020 02:50:51 EST
Received: from mailhost.staff.otago.ac.nz (its-mail-p02.registry.otago.ac.nz [10.67.0.56])
        by mailhub2.otago.ac.nz (8.13.8/8.13.8) with ESMTP id 00A7huYZ023644
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 20:43:56 +1300
Received: from its-mail-p04.registry.otago.ac.nz (10.67.0.68) by
 its-mail-p02.registry.otago.ac.nz (10.67.0.56) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3; Fri, 10 Jan 2020 20:43:55 +1300
Received: from its-mail-p04.registry.otago.ac.nz ([fe80::bd4c:10f5:161d:7ae6])
 by its-mail-p04.registry.otago.ac.nz ([fe80::bd4c:10f5:161d:7ae6%18]) with
 mapi id 15.00.1473.005; Fri, 10 Jan 2020 20:43:55 +1300
From:   Chris Edwards <chris.edwards@otago.ac.nz>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Paging out when Free memory is low but there is Available memory
 (kernel 5.3 and 5.4 at least)
Thread-Topic: Paging out when Free memory is low but there is Available memory
 (kernel 5.3 and 5.4 at least)
Thread-Index: AQHVx4m1IDekzINkRkeFHcm6j5RUqQ==
Date:   Fri, 10 Jan 2020 07:43:55 +0000
Message-ID: <6b7c2dfd3d44480e8240e586b5bf85cd@its-mail-p04.registry.otago.ac.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-NZ
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.32.117]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've observed a problem in recent kernels whereby the system will page out, continuously and seemingly needlessly, when Free memory is low but not exhausted. The system may have gigabytes of Available memory, yet begins paging out when buffer/filesystem cache squeezes out the remaining Free memory. Strangely, swap space utilisation does not increase over time, despite the continuous page-outs with little or no page-in activity.

I've observed this on 5.3 and 5.4 series kernels on Arch Linux on a Dell Optiplex 9020 (Intel Q87 Express, i5-4670 CPU, 12 GiB RAM).


To reproduce:


1. Get the system in a low-memory state, but not so low that it has to start paging, e.g. using stress/stress-ng:

	stress --vm-bytes $(awk '/MemAvailable/{printf "%d\n", $2 * 0.95;}' < /proc/meminfo)k --vm-keep -m 1

	Confirm that the system isn't paging, and that memory pressure reported by /proc/pressure/memory remains low:

	cat /proc/pressure/memory 
	some avg10=0.00 avg60=0.00 avg300=1.54 total=414331152
	full avg10=0.00 avg60=0.00 avg300=1.42 total=377927386


2. Perform an additional task that will fill up the filesystem cache and/or I/O buffers, such as dd.

	dd if=/dev/sda of=/dev/null bs=1048576


3. Observe system behaviour (with `vmstat 1`, `xosview`, etc.) while the free memory decreases. Here's what I witness using vmstat:

procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 2  0  62464 456132 591328 484656    0    0     0     0 1643 2859 26  1 74  0  0
 1  0  62464 456076 591328 484676    0    0     0     0 1684 2813 26  0 74  0  0
 1  0  62464 456084 591328 484660    0    0    88     0 2156 3212 25  1 73  1  0
 1  0  62208 456084 591328 485004    0    0     0     0 2284 3419 26  1 73  0  0
 1  0  62208 456184 591328 485004    0    0     0     0 2027 2990 26  1 74  0  0
 1  0  62208 456020 591328 485016    0    0     0     0 1960 2983 26  1 74  0  0
 4  0  62208 456052 591328 485016    0    0     0     0 2034 3046 26  1 73  0  0
 1  0  62208 456084 591328 485000    0    0     0     0 1882 2758 26  1 74  0  0
 1  1  62208 404384 642532 485000    0    0 51196    12 2027 3149 25  2 64  9  0	<- dd begins
 1  1  62344 385928 686292 460928    0  200 124928   200 2218 3785 25  3 55 18  0
 1  1  70356 394056 681360 453036    0 21700 81920 21700 2373 3577 26  4 40 31  0
 1  1  83576 380132 694960 439964    0 13532 99840 13532 2060 3560 25  3 48 24  0
 1  1  79552 391188 685408 443776    0 4264 123904  4264 2188 3742 25  3 54 19  0
 1  1  79616 395960 679076 443828    0 7628 108032  7628 2200 3686 26  2 52 20  0
 1  2  83456 389928 691104 435692    0 11136 104448 11136 2203 3660 25  2 49 23  0
 1  1  83968 415780 664744 435596    0 1480 121344  1480 2285 3630 25  3 54 18  0
 1  1  77312 419104 662376 442284    0 1176 124416  1176 2236 3662 25  4 56 16  0
 1  1  79872 398472 679452 439552    0 9164 110592  9164 2255 3703 25  3 49 23  0
 1  2  83200 389140 691968 436056    0 11132 108032 11132 2113 3550 25  3 47 25  0
 1  1  84480 396456 684096 435296    0 2364 109056  2364 2072 3542 26  2 51 21  0
 1  3  76032 391896 698608 433428    0 6712 110664  6712 2134 3696 25  3 49 23  0
 1  1  70144 408468 672888 447244  104 2016 36592  2016 2561 4609 25  2 32 41  0
 2  2  77312 356556 712208 442896    0 6880 40328  7052 2223 3580 31  2 25 41  0
 1  2  85504 500392 566936 449100    0 8780 30052 22128 2172 3588 26  3 19 52  0
 1  2  81408 391236 675480 453360    0 2804 108716  2804 2219 3535 25  2 53 20  0
 1  2  81152 379424 689692 452648    0 7408 104448  7408 2321 3665 25  3 48 23  0
 1  1  85104 409144 659932 448120    0 11704 94208 11704 2286 3682 25  3 47 25  0
 2  1  85368 396440 673868 448244   28 1212 99868  1288 2170 3569 25  2 46 27  0
 1  2  83968 385172 683892 449572    0 6588 118784  6588 2169 3904 25  3 53 19  0
 1  1  78848 388668 681108 454724    0 2172 118784  2284 2097 3724 25  3 50 22  0
 1  2  70912 419592 673860 438356    0 7340 84684  7340 1942 3672 25  3 43 29  0
 3  1  77824 406288 685452 433064    0 6940 55604  7060 2107 3755 25  2 34 39  0
 1  2  74496 394684 697252 436316    0 4028 118784  4028 2250 3894 25  2 52 21  0
 1  1  78080 417060 675348 433080    0 10884 102404 10884 2486 4609 25  3 47 25  0
 1  2  73984 397144 694840 437160   48 3508 106544  3580 2039 3672 25  2 49 23  0
 1  3  78080 365596 725560 434504  124 4024 31088  4024 1800 2932 25  2 27 46  0
 1  3  73216 373732 716676 438908  100 1952 34952  1952 1981 3335 26  1 26 47  0
 1  2  71680 380044 709484 441480   72 5204 26668  5204 1913 3376 26  1 22 51  0
 1  3  71424 394544 692012 442364   48 6696 27532  6696 1909 3291 27  1 15 58  0
 1  3  74908 392528 697372 438248   84 3584 27540  3600 1856 3232 25  2 15 57  0
 1  2  71168 417136 662892 449732   84 3768 29044  3768 1919 3385 26  2 29 43  0
 1  2  78932 417788 663360 441568    8 7932 86128  7932 2169 3579 26  2 45 27  0
 1  1  85108 439408 639828 435408    0 13660 101888 13660 2157 3461 25  3 48 25  0
 1  1  85364 402868 678052 434988    0 1136 123392  1136 2240 3797 25  3 56 15  0
 1  1  78460 380424 700440 442888    0 1008 124928  1008 2188 3745 25  3 56 17  0
 1  1  80896 386260 695628 439068    0 10108 91648 10108 2170 3572 26  2 46 27  0
 1  2  84480 389552 689404 435780    0 10988 100864 10988 2015 3450 25  2 48 24  0
 1  1  85404 415768 664708 434892    0 1980 122880  1980 2024 3658 25  3 53 19  0
 1  2  80128 385008 696088 439256    0 2116 124928  2116 2047 3657 24  3 55 18  0
 1  1  80896 390064 691756 438140    0 7784 112128  7784 2062 3621 25  3 50 21  0
 1  2  77824 384716 704968 431932    0 11384 98816 11384 1968 3587 26  2 47 26  0
 2  1  78848 395324 692572 431928    0 2240 118272  2240 2006 3716 25  2 54 18  0
 1  1  74332 392796 694952 436552    0 3560 120832  3560 2098 3868 26  2 53 19  0
 1  1  78336 402544 684296 433416    0 12032 96256 12032 1959 3421 25  3 45 27  0
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----

There is considerable paging-out activity ("so" column), despite having available memory. Swap space utilisation rises briefly, then remains roughly constant. I am surprised to see any page-outs, let alone constant. And with several kilo-blocks being paged out per second, and negligible page-in activity, shouldn't swap be growing by about a megabyte per second?

The kernel seems to think it's under some memory pressure:

cat /proc/pressure/memory 
some avg10=8.01 avg60=5.44 avg300=2.70 total=422931595
full avg10=7.66 avg60=5.15 avg300=2.53 total=385972806

The paging activity stops when the dd process finishes or is killed or suspended.


4. Null test: To show that it's not the dd process that's causing the memory pressure, read from a device that won't add to buffer cache (memory hog still running):

dd if=/dev/zero of=/dev/null bs=1048576

procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 2  0  67584 432504 622944 487216    0    0     0     0 2165 3512 26  1 73  0  0
 1  0  67584 432440 622944 487292    0    0     0     0 2211 3457 26  1 73  0  0
 1  0  67584 432180 622944 487292    0    0     0    88 1947 3033 26  1 74  0  0
 1  0  67584 431896 622944 487352    0    0     0     0 1729 2810 26  1 73  0  0
 1  0  67584 431644 622944 487272    0    0     0     0 1936 2935 26  1 73  0  0
..

cat /proc/pressure/memory 
some avg10=0.00 avg60=0.10 avg300=1.48 total=427081339
full avg10=0.00 avg60=0.10 avg300=1.39 total=389910888

No problem.

The problematic behaviour is also seen when the filesystem cache (rather than the buffer cache) is exercised, e.g. md5sum /some/big/files/*.

The needless paging out is also seen without a "memory hog" running alongside the buffer/fs cache exerciser - it just takes longer to reach the point at which it starts paging out, and reclaims more of the cache memory between paging bursts. A graph of memory used has a visible, irregular sawtooth shape.

Deactivating swap altogether avoids the problem. ;) Setting vm.swappiness to 1 or 0 does not.

Purging the cache with "echo 3 > /proc/sys/vm/drop_caches" stops the paging-out activity temporarily, until the buff/cache utilisation creeps up again. vmstat output again:

procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0  67072 409928  21952 1107556    0    0     0     0 1772 2808 26  1 74  0  0
 1  0  67072 409644  21952 1107564    0    0     0     0 2005 3320 26  1 73  0  0
 1  0  67072 409644  21952 1107564    0    0     0     0 1906 3035 26  1 73  0  0
 1  0  67072 415944  21952 1100744    0    0     0     0 2083 3709 27  1 72  0  0
 1  0  67072 415944  21952 1100744    0    0     0     0 1960 3203 26  1 73  0  0
 1  0  67072 415156  21952 1100688    0    0     0     0 1941 3307 26  1 73  0  0
 1  0  67072 415604  21968 1100672    0    0     0   116 1722 2856 26  1 70  3  0
 1  0  67072 415376  21968 1100672    0    0     0     0 1682 2888 26  1 73  0  0
 1  1  67072 401004  35744 1100620    0    0 13780   116 1725 3006 26  1 70  3  0	<- dd begins
 1  2  71936 394432 142240 994452    0 7516 106496  7564 2407 4083 27  4 49 21  0
 1  1  83456 444492 231840 846960    0 19064 89600 19064 2389 4114 26  4 45 25  0
 1  1  83200 470376 334240 715248    0 7496 102400  7496 2338 4018 26  5 48 21  0
 1  1  83456 471480 436028 612844    0 7696 109568  7696 2390 4063 27  4 49 20  0
 1  1  75116 427784 488760 611496    0 6968 111104  6968 2360 4049 26  5 51 19  0
 1  1  75520 381788 534760 612608    0 7548 96256  7560 2296 3922 26  4 47 23  0
 1  1  75564 387984 556520 583716    0 7080 124416  7080 2326 3986 27  5 55 14  0
 1  1  75480 400808 582600 545416    0 7360 112128  7360 2357 3800 26  5 52 17  0
 2  1  75520 1104992  23844 398784    0 7460 115712  7460 2449 3981 27 19 37 18  0	<- drop_caches
 1  2  68608 1087920  49220 398004  100  168 26036   168 1919 3251 26  2 23 49  0
 1  2  68352 1062184  72400 401876    4    0 25324    20 1875 3019 26  2 35 38  0
 2  0  68352 970188 164048 402676    0    0 92364     0 2166 3662 28  3 45 24  0
 1  1  68352 846924 288464 402920    0    0 124416     0 2304 3919 26  4 56 14  0
 1  1  68352 723664 412880 402616    0    0 124416     0 2447 3754 26  4 55 15  0
 1  1  68352 599428 537296 402492    0    0 124416     0 2467 3765 26  4 55 15  0
 1  3  68352 477680 658644 402940    4    0 121376    16 2495 3886 26  3 55 15  0
 1  2  75776 431236 706620 394264    0 15488 94216 15492 2410 4113 27  5 44 24  0
 1  1  75636 383948 754740 394340    0 7972 114176  7972 2382 4015 26  5 49 19  0
 1  1  75520 391220 747020 394252    0 7028 115712  7028 2331 3886 27  4 52 18  0
 1  1  75264 393764 744824 394080    0 7360 95232  7512 2425 4030 26  4 45 24  0
 2  0  70912 389928 747168 397940    0 3028 110080  3028 2427 3861 26  4 51 18  0
 1  1  68352 1075872  62280 400020    0 4512 86144  4524 2325 3696 26  5 44 25  0	<- drop_caches
 1  1  68352 951904 185160 401044    0    0 122880     0 2534 4059 27  5 54 14  0
 1  1  68352 829684 308552 401072    0    0 123392     0 2443 3827 26  5 56 13  0
 1  1  68352 696240 432968 410196    0    0 124416     0 2488 3881 28  4 53 15  0
 1  1  68352 571720 557384 409932    0    0 124416     0 2444 3849 27  4 57 13  0
 1  1  68352 447232 681800 410264    0    0 124416     0 2380 3861 26  4 57 12  0
 2  1  75520 450164 688464 392212    0 7444 97280  7464 2465 3807 26  4 47 23  0
 2  0  68608 417208 721452 398936    0  252 123904   252 2433 4068 27  5 56 13  0
 1  1  68608 391724 743596 400604    0 7040 114176  7040 2480 3835 27  5 51 18  0
 1  1  76032 404348 733084 391932    0 14976 104960 14976 2454 4065 26  5 47 22  0

Any thoughts? Could this behaviour could be by design? I'm happy to try to help troubleshoot further.

Best regards,
Chris
