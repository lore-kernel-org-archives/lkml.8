Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA448C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B9820746
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UThROAwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgCKRVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:21:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:57717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbgCKRVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583947280;
        bh=N0Mt55tH5t+Up1Jf8+V0Xwu+VhOGcetuqNUN75M6s/I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UThROAwY0Puz8teOBw7m281B3Y6r+rjHOyIzEYgi3j+RzqW+TmcT9VGkd5OCr+yQR
         RIiZRkn1P1mkFsfAWj9XbUUGiCB7Dl1bzLF1ABmPGGr7PizyCT5UNh4NnGIKmimtJL
         9wik/tB+lfHjN3qn3lDHgfgreBBHBGetgn0EfI6s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.94.10.10] ([196.52.84.11]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MC34h-1j1ve10gZB-00CQMU; Wed, 11
 Mar 2020 18:21:20 +0100
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu <iommu@lists.linux-foundation.org>
References: <bug-206175-5873@https.bugzilla.kernel.org/>
 <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de>
 <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
 <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de>
 <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com>
 <20200311154328.GA24044@lst.de> <20200311154718.GB24044@lst.de>
 <962693d9-b595-c44d-1390-e044f29e91d3@gmx.com>
 <CAHk-=wj0E9vCO_VTiK6xuXAW13ZeeLsW=G3v+yNsCaUm1+H61A@mail.gmail.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
Message-ID: <e97de44a-39b0-c4fa-488c-d9fa76eb1eae@gmx.com>
Date:   Wed, 11 Mar 2020 17:21:18 +0000
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj0E9vCO_VTiK6xuXAW13ZeeLsW=G3v+yNsCaUm1+H61A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ze7y1s6CHNlylCGF1+im6WZhD4xZTD+aR40SqUuS7Nb0FZg3KBM
 HD/zOBY6QVgIkackJElkVcjFBpuhL4AexRdeMdI/rFfAXRe9UqzngsLOx8A8YDq9wxkF3KZ
 F87fUG7rOr0LPnDTxFdhAGTZ5F2S1FX0Fl695oJJtXGjmWA6tdgU+zq44+k1OhTJ8UAnZ83
 nKF8NiFlAS331rxR1VwoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R0sDNHJ+Vm4=:kBnZF+dTpOcEkg0WvtmBEI
 kPihdaA/As3/lGXNTUOzoDtVZzwsTuaKdzSbFCB0pG9SjO7hE62YONOb1kgUU6cwoTzbkWFSv
 jlsbAkTbKboPX4LcwX7BRThXcu6NNzR4YfHSgV1LM8GNWpQK8oTSClnXAd6Jh40rWN9lF+cE6
 TxgEHwnEVzrGboYSSsxibnPbX8F1HjMYl/f+GjMIwQ540ghvzn1bGXzsr3ZpyLyPVCdDYqu5j
 1arWraV/da5227dPAlg8kcozOib30DHziNJo8NNUFBZOthbQ8S7tgr57P+T0gEVp9x2O2TFXZ
 GCwzBFuJLs6HA2Du4uHRN0mJuWTbiDAmYpGIAXGTid/s+GT1RMFb14PfTcSTNLIXiN/l1YFN3
 yKCfBB6b0NR2PksAfly6xNBqi1YAi2EkS2rt4EJSAMNcyFg9saVhngTQoublBs5TZUKK+tq8R
 OF/MNwqhb6+Y9FHWR6TGbLmXzvJxC1b2hpOyZw58a7+0mhQSxgBjVHIff/kJ9YtNjGKNFIUYj
 fqJV9yF/2OFHRC4CFPdgeSylr0qPa1+DauQdDB/PRXgCIN460t3VU2cs8NpIWvYqwLmEGlkL3
 4ti8TmZkmZftyfXMMcqoYd5BtRxQYAxbO2qesM3TOQZuO+xzsrvjWlnrPhssWR0ZVdqdfwEDz
 384BPbOhhuIeKPuZMD1Z+XEon9u3jSQ+rbkKJDJJjckMt/NT8fOesb4rxE79udG15Lxf5MeJn
 +N8ATuyG9bRrMF8FTLqBaPwyIDY8J6MEuuedpsB7f1Mdu5Y/9ZUWsz1hR1ZGtuLZvApIdWXcR
 BH5u0UitU64nRqqtlpX1YFPm7a/seA+lydKe8BGsD0qLSbTQ+py7mKWZ/vSy9ka4iqepeFjd+
 wZipi0uXeIlo/6sBojHVyMXrAO2hy18vYwFh2A3C3ahbWhFXJLFBBaJwmCCiqWjLAp87PY0Gj
 3S9MBCuZyRMYj+lRF7JnSyna2Qtk4r5JiVqQI/HDMOXOEVUZzszP6jevvHg9nv9SOvuNkbuLh
 hK92Ddg9wZZ5LHJN9yz3XhktnaJGLAT3B7GBtO991/EuPjDPhIreeRDiGOmM/s1TGm/wZMijF
 yl+UDHrbOH8CTr16c9VbwvyFT8Hc/tmxWX9pFKmaafmASUOXO4cvuBm/CJcVxjuvBDmAQ1eBM
 l3j2tIPVyH0Y4ltKmhUCwIS2CeRB6+asXBoJ7ksitvWzb8gmtfRnR7VEkBtHm+zUcAdqnXNoX
 YHijdGB3L4XA6g1cm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/20 4:21 PM, Linus Torvalds wrote:
> On Wed, Mar 11, 2020 at 9:02 AM Artem S. Tashkinov <aros@gmx.com> wrote:
>>
>> With this patch the system works (I haven't created an initrd, so it
>> doesn't completely boot and panics on not being able to mount root fs
>> but that's expected).
>
> Perfect.
>
> I ended up applying my earlier cleanup patch with just the added
> removal of the kfree(), which was the actual trigger of the bug.
>
> It's commit e423fb6929d4 ("driver code: clarify and fix platform
> device DMA mask allocation") in my tree. I've not pushed it out yet (I
> have a few pending pull requests), but it should be out shortly.


I've been able to compile and run
e3a36eb6dfaeea8175c05d5915dcf0b939be6dab successfully. I won't claim
this patch doesn't break something for other people :-)

Best regards,
Artem
