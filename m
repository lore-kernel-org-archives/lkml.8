Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2958FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E256C2077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FewkuPVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgFANZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:25:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44663 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFANZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:25:17 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200601132515euoutp027f403cc66144b1f4d87415a87ce64656~Ubl1g7EsO1799517995euoutp02j
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 13:25:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200601132515euoutp027f403cc66144b1f4d87415a87ce64656~Ubl1g7EsO1799517995euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591017915;
        bh=8vJu5WoSJc1bPlFRS2kAudUcVnFFPbiM6d2gECaeE2A=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=FewkuPVOViSeylJfXcwjWoiaBI70QjGFRR6dC8t2ljtmVvWd5v4VE/h+1GpEXYWHP
         KJf69YjByKG7A65Ef+aptQwsH6PYOVCTD891T2Hff5BBZ7FGJF0Hczp2S+xgdvcCfb
         JcAnE2oJMLk31SlEvNiiWSBg/S58JbO1A2bcmrzg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200601132515eucas1p227402478c49b1fea20831ef25e9d469e~Ubl1USyP92098120981eucas1p2n;
        Mon,  1 Jun 2020 13:25:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 35.33.60679.BB105DE5; Mon,  1
        Jun 2020 14:25:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601132514eucas1p14257ed00a14e2c2b285e30099cc283ce~Ubl0jF8XG1280112801eucas1p1h;
        Mon,  1 Jun 2020 13:25:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200601132514eusmtrp11c2bb965cd5055cf7ae19bf083709249~Ubl0iVzos2270722707eusmtrp1V;
        Mon,  1 Jun 2020 13:25:14 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-35-5ed501bbe442
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1C.DB.08375.AB105DE5; Mon,  1
        Jun 2020 14:25:14 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200601132514eusmtip15d4f8e602708b33e993ba077aeb98600~Ubl0NBAbr0583405834eusmtip1i;
        Mon,  1 Jun 2020 13:25:14 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3] console: newport_con: fix an issue about leak
 related system resources
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de, akpm@osdl.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Message-ID: <f1533c61-d112-35a2-a5f3-d6fae596b335@samsung.com>
Date:   Mon, 1 Jun 2020 15:25:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200423164251.3349-1-zhengdejin5@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zk7O5Nmx2n5YlI2u4OX1B+HLnbBH6NfEf3IwMt0h2m6TTZ1
        WURLS22aOUXEYRcM1KzUZug2iWKjVg2XppmZZohGTqfhNMrMch4l/z3v87zP9zwvfCQmbOcG
        kemKbEalkGSKCB+8/eUvZ1gnep8YWTMeRJsbS3n0RLkN0X3zMwRdcK+FoF+VfefSvZZagm4z
        VmG0ZfQjdpQUmw3DPPG008kTP7v1kCceKbFzxP1v55HYY9x6kjjrc0jKZKbnMqqI2GSfNFv+
        EJF1Lfh8v1aPa5F9sw7xSaBi4HdPHUeHfEgh1YhgqsOIs8McAoPxOcYOHgStFVp8zVJhHiBY
        oQHB4BU9Ygc3gs6paa53i6AOgL6oCXmxP5UMA839PC8OoHZDzdWbKxkY5UQwUagjvIKAioU2
        j3vZQJI4tQN+3E3x0puoMzD7xcZlV/zgdc3YSgv+8vuWkaUVK0YFwuDYHQ6Lt0GHu3alNlBW
        How9fcNja8dB6YgdY7E/uOxPVvlgcFSW4qyhGcGf4m+r7g4EDZVsBFAHYci5QHjbYdReaLFE
        sPQxqC93YV4aKF8YcPuxJXyhor16lRZAcaGQ3d4FrfWtxFqsznwfK0ciw7rTDOvOMaw7x/A/
        9y7Cm1Agk6OWyxh1lILRhKslcnWOQhaeqpQb0fJvcizZ50zIsphiRRSJRBsE5GhfopAryVXn
        ya0ISEwUIDje5UgUCqSSvAuMSpmkyslk1Fa0hcRFgYLouokEISWTZDMZDJPFqNZUDskP0qJz
        o8zsjfSa67pTohcli8JhJjUjtK/LEacpmjxBQINC2fN1p3N8pnj77Z8Xcz886i6kH/MLql0x
        mr/d8ap6W0iqUhofLeveWKbRR2r5HtNwqOIzJyZEGRa1p53rOjyzMNlfx3nnJ/10mTEE9eYf
        OZ0Uar0UbEpoHKwyPWirrhfh6jTJ/n2YSi35B6BxbF5JAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7q7GK/GGXR8U7PYuaKH3eLlhMOM
        Fle+vmezaF68ns3iRN8HVovLu+awWWzeNJXZYtejm8wOHB47Z91l93h37hy7x/65a9g97ncf
        Z/K4dv4ro8fnTXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2Nimp
        OZllqUX6dgl6GYeb7rAVtMpUXGuYyNLAeFysi5GTQ0LARGLSzhtsXYxcHEICSxkl9m24zNjF
        yAGUkJE4vr4MokZY4s+1Lqia14wSZ9YuZQRJsAlYSUxsXwVmCwskSDxZ8Y4ZxBYRUJeY2dLP
        AtLALHCOUeL2t0uMEN29jBK/9+4D6+AVsJPY/Pkt2DYWARWJbwuSQMKiAhESh3fMgioRlDg5
        8wkLiM0JtGzX/X9sIDYz0II/8y4xQ9jiEreezGeCsOUltr+dwzyBUWgWkvZZSFpmIWmZhaRl
        ASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBI3Hbs5+YdjJc2Bh9iFOBgVOLh3XD/SpwQ
        a2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAv02kVlKNDkfmCTySuINTQ3N
        LSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwVj2vaiu+dMJl9i7FTIUTf40/
        zz3AtSZ34ay/dUt/rw9mSb0/j5HT26Enip3jKlfqJY7HVTEbcz4v/lm06/4fC625Nle2nTbf
        cKAl6ur7IPngX/P/cfyw6bWxy3v9Nu3XDnGbVtHZOxarsId3fl9Ulut/jvX0m4qCh6fbDm7s
        VXP9Vuiv+kZLVImlOCPRUIu5qDgRAJeWBoLaAgAA
X-CMS-MailID: 20200601132514eucas1p14257ed00a14e2c2b285e30099cc283ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200423164300eucas1p286ebc9584639c8e8b6311dbf10355808
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200423164300eucas1p286ebc9584639c8e8b6311dbf10355808
References: <CGME20200423164300eucas1p286ebc9584639c8e8b6311dbf10355808@eucas1p2.samsung.com>
        <20200423164251.3349-1-zhengdejin5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/23/20 6:42 PM, Dejin Zheng wrote:
> A call of the function do_take_over_console() can fail here.
> The corresponding system resources were not released then.
> Thus add a call of iounmap() and release_mem_region()
> together with the check of a failure predicate. and also
> add release_mem_region() on device removal.
> 
> Fixes: e86bb8acc0fdc ("[PATCH] VT binding: Make newport_con support binding")
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Applied to drm-misc-next tree (patch should show up in v5.9), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> v2 -> v3:
> 	- modify commit tag CC to Cc by Andy's suggestion.
> 	- modify Subject 'console: console:' to 'console: newport_con:'
> 	  by Bartlomiej's suggestion.
> 	- add missing release_mem_region() on error and on device removal
> 	  by Bartlomiej's suggestion.
> 	- add correct fixes commit, before this patch, add a wrong 'Fixes:
> 	  e84de0c6190503 ("MIPS: GIO bus support for SGI IP22/28")'
> 	  thanks Bartlomiej again!
> 
> v1 -> v2:
> 	- modify the commit comments. The commit comments have some more
> 	  appropriate instructions by Markus'suggestion. here is my first
> 	  version commit comments:
> 
> 	  if do_take_over_console() return an error in the newport_probe(),
> 	  due to the io virtual address is not released, it will cause a
> 	  leak.
> 	 
>  drivers/video/console/newport_con.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
> index 00dddf6e08b0..2d2ee17052e8 100644
> --- a/drivers/video/console/newport_con.c
> +++ b/drivers/video/console/newport_con.c
> @@ -32,6 +32,8 @@
>  #include <linux/linux_logo.h>
>  #include <linux/font.h>
>  
> +#define NEWPORT_LEN	0x10000
> +
>  #define FONT_DATA ((unsigned char *)font_vga_8x16.data)
>  
>  /* borrowed from fbcon.c */
> @@ -43,6 +45,7 @@
>  static unsigned char *font_data[MAX_NR_CONSOLES];
>  
>  static struct newport_regs *npregs;
> +static unsigned long newport_addr;
>  
>  static int logo_active;
>  static int topscan;
> @@ -702,7 +705,6 @@ const struct consw newport_con = {
>  static int newport_probe(struct gio_device *dev,
>  			 const struct gio_device_id *id)
>  {
> -	unsigned long newport_addr;
>  	int err;
>  
>  	if (!dev->resource.start)
> @@ -712,7 +714,7 @@ static int newport_probe(struct gio_device *dev,
>  		return -EBUSY; /* we only support one Newport as console */
>  
>  	newport_addr = dev->resource.start + 0xF0000;
> -	if (!request_mem_region(newport_addr, 0x10000, "Newport"))
> +	if (!request_mem_region(newport_addr, NEWPORT_LEN, "Newport"))
>  		return -ENODEV;
>  
>  	npregs = (struct newport_regs *)/* ioremap cannot fail */
> @@ -720,6 +722,11 @@ static int newport_probe(struct gio_device *dev,
>  	console_lock();
>  	err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
>  	console_unlock();
> +
> +	if (err) {
> +		iounmap((void *)npregs);
> +		release_mem_region(newport_addr, NEWPORT_LEN);
> +	}
>  	return err;
>  }
>  
> @@ -727,6 +734,7 @@ static void newport_remove(struct gio_device *dev)
>  {
>  	give_up_console(&newport_con);
>  	iounmap((void *)npregs);
> +	release_mem_region(newport_addr, NEWPORT_LEN);
>  }
>  
>  static struct gio_device_id newport_ids[] = {
> 

