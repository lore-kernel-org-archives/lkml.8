Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E272C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E372B2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p890qtW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgAOPbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:31:14 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33000 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbgAOPbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:31:13 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200115153111euoutp01961377abf38d60761dcdf06c22c3bbb8~qGSZc35SB1034110341euoutp01T
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 15:31:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200115153111euoutp01961377abf38d60761dcdf06c22c3bbb8~qGSZc35SB1034110341euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579102271;
        bh=4F4bXKE0OPKAZ+2SFzxOd6GGJMe648prhny7d5Y+sos=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=p890qtW40tCeu5qnjXaOTocu051jqKOFZ8TG+l8Zlj5njbGBITreEMDKd71nShxxw
         BLCzIoovPr83PSGCPjTzf5HEiYz4xVyKcIpDq70wr+lBajxo4nR9yLrrvFebNWLBh+
         LkNsihvX+6aTQjYMa/ee2DM9/QEqcXQNSpCofoGw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200115153111eucas1p1babb1a4f8d73fa88fcca05f74bc234e0~qGSZSvuMp0514505145eucas1p1s;
        Wed, 15 Jan 2020 15:31:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E1.FF.60679.F303F1E5; Wed, 15
        Jan 2020 15:31:11 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200115153111eucas1p28e7029964b89fbb273ce99df06939700~qGSZAjTjR0669906699eucas1p2G;
        Wed, 15 Jan 2020 15:31:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200115153111eusmtrp2d399bd48e64649e259929cb618aa4d03~qGSY-_eJj0087600876eusmtrp2W;
        Wed, 15 Jan 2020 15:31:11 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-a4-5e1f303f998d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E6.6F.07950.F303F1E5; Wed, 15
        Jan 2020 15:31:11 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115153110eusmtip17aa2d6756fa826336d731a189b5bce67~qGSYbt2UR2349523495eusmtip1u;
        Wed, 15 Jan 2020 15:31:10 +0000 (GMT)
Subject: Re: [PATCH] video: ssd1307fb: add the missed regulator_disable
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Chuhong Yuan <hslester96@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <8c4c9d8d-f85f-1d46-4f8d-5423028a72c2@samsung.com>
Date:   Wed, 15 Jan 2020 16:31:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <efd5bc3a-9c3b-2d66-7aa1-c06748294fc3@ysoft.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87r2BvJxBjumaVtc+fqezWL2oZfM
        Fif6PrBaXN41h83i/+cnrA6sHjtn3WX3uN99nMnj8yY5j5d/PzAHsERx2aSk5mSWpRbp2yVw
        Zbx/up69YKF6xcTPeQ2Mu5W6GDk5JARMJB6f+cbSxcjFISSwglFiT8cfVgjnC6PEuv5OqMxn
        Ronl67axw7Tc+b2YDSKxnFHi79knUFVvGSU6l+9kBakSFnCX+L1iO1AVB4eIQIpEwyZ7kDCz
        QILE6UX3WEBsNgEriYntqxhBbF4BO4lDh9+ygJSzCKhK7D+kCRIWFYiQ+PTgMCtEiaDEyZlP
        wFo5BWwlll9/yAgxUlzi1pP5TBC2vETz1tnMIOdICMxjl5h0dyEbxNEuEk+OtkE9ICzx6vgW
        KFtG4v9OkGaQhnVAz3S8gOreDvTy5H9Q3dYSd879AnuGWUBTYv0ufYiwo8TLv3PAwhICfBI3
        3gpCHMEnMWnbdGaIMK9ER5sQRLWaxIZlG9hg1nbtXMk8gVFpFpLXZiF5ZxaSd2Yh7F3AyLKK
        UTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMMWc/nf8yw7GXX+SDjEKcDAq8fBm/JGLE2JN
        LCuuzD3EKMHBrCTCe3KGbJwQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1ML
        UotgskwcnFINjKwn7Gct/HVBZmV/arFcmqPHTvar11Imf1+nkqUcmjP1qqm3/bHztvdPFirn
        dukvTeBM734QPM/W7u23k8Vz5Vekmnd+6vl4YF5zALOej7nnVa6UgPUcPKyBUx3WHzNfbe/8
        +P2hE6fPpdtz28R4pajO8DESzV7dlspo8vfjpj8KwuxbWZaUKLEUZyQaajEXFScCAAFo2vct
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xu7r2BvJxBod/iVhc+fqezWL2oZfM
        Fif6PrBaXN41h83i/+cnrA6sHjtn3WX3uN99nMnj8yY5j5d/PzAHsETp2RTll5akKmTkF5fY
        KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZbx/up69YKF6xcTPeQ2Mu5W6
        GDk5JARMJO78XszWxcjFISSwlFHi3ePtQA4HUEJG4vj6MogaYYk/17qgal4zSjyZfZ0ZJCEs
        4C7xewVIPSeHiECKxLk3m9lBepkFEiSezUuBqD/AKHF36WQWkBo2ASuJie2rGEFsXgE7iUOH
        37KA1LMIqErsP6QJEhYViJA4vGMWVImgxMmZT8BaOQVsJZZffwgWZxZQl/gz7xIzhC0ucevJ
        fCYIW16ieets5gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525i
        BEbUtmM/t+xg7HoXfIhRgINRiYf3wD+5OCHWxLLiytxDjBIczEoivCdnyMYJ8aYkVlalFuXH
        F5XmpBYfYjQF+m0is5Rocj4w2vNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQW
        wfQxcXBKNTDO/NY+9Vfoxq+Vnt38QtssTERNvm4oN3dQOpwpK99sFJjQ/1R0tf5yj8kuLg+k
        /nMtkVDmP3CaoW6KfCtLg1jtwtyqK66W5WxhcybN3zatYFE2y7omxwuVPWEzmCeKZF7QnjWX
        LyQ//cBShc2if7YpLQ5T+TPBOqRfotZ2ceqljQmVla1P5ymxFGckGmoxFxUnAgCiliyWvgIA
        AA==
X-CMS-MailID: 20200115153111eucas1p28e7029964b89fbb273ce99df06939700
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191206140944epcas3p298db1ab394da9960226f9d4eeb9878ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191206140944epcas3p298db1ab394da9960226f9d4eeb9878ab
References: <20191118114150.25724-1-hslester96@gmail.com>
        <CGME20191206140944epcas3p298db1ab394da9960226f9d4eeb9878ab@epcas3p2.samsung.com>
        <efd5bc3a-9c3b-2d66-7aa1-c06748294fc3@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/19 3:09 PM, Michal Vokáč wrote:
> On 18. 11. 19 12:41, Chuhong Yuan wrote:
>> The driver forgets to disable the regulator in remove like what is done
>> in probe failure.
>> Add the missed call to fix it.
>>
>> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
>> ---
>>   drivers/video/fbdev/ssd1307fb.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
>> index 78ca7ffc40c2..819fbee18dda 100644
>> --- a/drivers/video/fbdev/ssd1307fb.c
>> +++ b/drivers/video/fbdev/ssd1307fb.c
>> @@ -791,6 +791,8 @@ static int ssd1307fb_remove(struct i2c_client *client)
>>           pwm_disable(par->pwm);
>>           pwm_put(par->pwm);
>>       }
> 
> An empty line missing here?
> 
>> +    if (par->vbat_reg)
>> +        regulator_disable(par->vbat_reg);
>>       fb_deferred_io_cleanup(info);
>>       __free_pages(__va(info->fix.smem_start), get_order(info->fix.smem_len));
>>       framebuffer_release(info);
>>
> 
> I have tested this on imx6dl-yapp4-hydra board with SSD1305 and this fixes
> the following problem when unloading the driver:
> 
> root@imx6qdlsabresd:~# rmmod ssd1307fb
> [  191.792674] ------------[ cut here ]------------
> [  191.797453] WARNING: CPU: 0 PID: 858 at /mnt/ssd/users/vokac/development/sources/linux-fslc/drivers/regulator/core.c:2047 _regulator_put.part.6+0x178/0x180
> [  191.811464] Modules linked in: ssd1307fb(-)
> [  191.815688] CPU: 0 PID: 858 Comm: rmmod Not tainted 5.4.0-next-20191128-00005-g121a1da986f1-dirty #14
> [  191.824914] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [  191.831445] Backtrace:
> [  191.833909] [<8010d878>] (dump_backtrace) from [<8010db8c>] (show_stack+0x20/0x24)
> [  191.841490]  r7:00000009 r6:60060013 r5:00000000 r4:812d96b0
> [  191.847164] [<8010db6c>] (show_stack) from [<80c1fa24>] (dump_stack+0x9c/0xb0)
> [  191.854395] [<80c1f988>] (dump_stack) from [<80126cec>] (__warn+0xec/0x104)
> [  191.861362]  r7:00000009 r6:80ff25c0 r5:00000000 r4:00000000
> [  191.867029] [<80126c00>] (__warn) from [<80126dbc>] (warn_slowpath_fmt+0xb8/0xc0)
> [  191.874519]  r9:00000009 r8:805a2e00 r7:000007ff r6:80ff25c0 r5:00000000 r4:81206788
> [  191.882274] [<80126d08>] (warn_slowpath_fmt) from [<805a2e00>] (_regulator_put.part.6+0x178/0x180)
> [  191.891239]  r9:ed261200 r8:ed261b00 r7:ed3d9e64 r6:ec413020 r5:81206788 r4:ecaaa400
> [  191.898991] [<805a2c88>] (_regulator_put.part.6) from [<805a2e40>] (regulator_put+0x38/0x48)
> [  191.907435]  r9:ed261200 r8:ed261b00 r7:ed3d9e64 r6:ec413020 r5:81206788 r4:ecaaa400
> [  191.915190] [<805a2e08>] (regulator_put) from [<805a9540>] (devm_regulator_release+0x1c/0x20)
> [  191.923716]  r5:81206788 r4:00000003
> [  191.927303] [<805a9524>] (devm_regulator_release) from [<8065b848>] (release_nodes+0x1c8/0x208)
> [  191.936007] [<8065b680>] (release_nodes) from [<8065b9e0>] (devres_release_all+0x40/0x60)
> [  191.944191]  r10:00000081 r9:ed3d8000 r8:80101204 r7:00000081 r6:7f00307c r5:ec412c80
> [  191.952023]  r4:ec413020
> [  191.954568] [<8065b9a0>] (devres_release_all) from [<80657244>] (device_release_driver_internal+0x108/0x1b0)
> [  191.964397]  r5:ec412c80 r4:ec413020
> [  191.967981] [<8065713c>] (device_release_driver_internal) from [<80657398>] (driver_detach+0x64/0xb0)
> [  191.977205]  r7:00000081 r6:00cfdebc r5:7f00307c r4:ec413020
> [  191.982872] [<80657334>] (driver_detach) from [<80655ce4>] (bus_remove_driver+0x5c/0xb0)
> [  191.990965]  r5:7f003140 r4:7f00307c
> [  191.994549] [<80655c88>] (bus_remove_driver) from [<80657d88>] (driver_unregister+0x38/0x5c)
> [  192.002989]  r5:7f003140 r4:7f00307c
> [  192.006579] [<80657d50>] (driver_unregister) from [<8078290c>] (i2c_del_driver+0x2c/0x30)
> [  192.014759]  r5:7f003140 r4:7f003060
> [  192.018356] [<807828e0>] (i2c_del_driver) from [<7f001754>] (ssd1307fb_driver_exit+0x14/0x8c0 [ssd1307fb])
> [  192.028013]  r5:7f003140 r4:81206788
> [  192.031604] [<7f001740>] (ssd1307fb_driver_exit [ssd1307fb]) from [<801c36b8>] (sys_delete_module+0x138/0x208)
> [  192.041615] [<801c3580>] (sys_delete_module) from [<80101000>] (ret_fast_syscall+0x0/0x54)
> [  192.049882] Exception stack(0xed3d9fa8 to 0xed3d9ff0)
> [  192.054941] 9fa0:                   00000002 7eb4ac28 00cfdebc 00000800 00000064 00000000
> [  192.063125] 9fc0: 00000002 7eb4ac28 00000000 00000081 7eb4af0e 00cfde80 7eb4ae0c 00000001
> [  192.071306] 9fe0: 76f0ec61 7eb4abe4 0001b403 76f0ec68
> [  192.076363]  r6:00000000 r5:7eb4ac28 r4:00000002
> [  192.081033] ---[ end trace af216f02771e12a7 ]---
> 
> 
> With this patch the problem disappears. Thanks.
> 
> Tested-by: Michal Vokáč <michal.vokac@ysoft.com>

Patch queued for v5.6, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
