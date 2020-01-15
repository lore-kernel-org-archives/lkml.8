Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77851C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C4C24671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aqMZjwvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgAOP1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:27:18 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60070 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgAOP1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:27:16 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200115152714euoutp01e503b121ceef585591c16ffdc656b412~qGO8Fqt-y0533405334euoutp01N
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 15:27:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200115152714euoutp01e503b121ceef585591c16ffdc656b412~qGO8Fqt-y0533405334euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579102034;
        bh=hMyI40UIhRALDeJv+8/Lna8KxKQQhTKYEAq92LnGRYo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aqMZjwvf3ZTU3cZWbFq9C64YBCoS6SW5ANpytHqIyYRdQSLFZNv3WCp8NcRJZ27Dh
         Kuzee8FsS9MZN32zVf1Th1HQxmnRi6LOelyFEp8iTZ8SOUveI4EVBTKaDSFuMJe1eh
         31ptmGSOH14nm7OOLDoo2KvNRAkkEw36bb34bY6I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200115152714eucas1p12d00f44a891d5aebac125dca5ca74814~qGO76ElhN2132721327eucas1p1A;
        Wed, 15 Jan 2020 15:27:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C8.53.61286.15F2F1E5; Wed, 15
        Jan 2020 15:27:13 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200115152713eucas1p2708b37fefac03525989791e8f7094807~qGO7s-SzA1245112451eucas1p2o;
        Wed, 15 Jan 2020 15:27:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200115152713eusmtrp2904886fb1b68fdb4b11e496d5937abd0~qGO7sZTQb2993929939eusmtrp26;
        Wed, 15 Jan 2020 15:27:13 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-6d-5e1f2f514aec
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.EE.07950.15F2F1E5; Wed, 15
        Jan 2020 15:27:13 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115152713eusmtip16aaa767aac23db588b65c033d694901d~qGO7O86iy1594115941eusmtip1c;
        Wed, 15 Jan 2020 15:27:13 +0000 (GMT)
Subject: Re: [PATCH] fbdev: s1d13xxxfb: add missed unregister_framebuffer in
 remove
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <d13e08ff-befc-978c-0216-a4b0c60f1354@samsung.com>
Date:   Wed, 15 Jan 2020 16:27:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191118080900.30634-1-hslester96@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7qB+vJxBktabC2ufH3PZjH70Etm
        i3knJSxO9H1gtbi8aw6bA6vHzll32T3udx9n8vi8SS6AOYrLJiU1J7MstUjfLoErY/GBm2wF
        m7gqnq78yd7AeIyji5GTQ0LARGLy/A1sXYxcHEICKxgl/nzdxArhfGGUuPv8DiOE85lRYvmN
        VcxdjBxgLVd+GULElzNK7Fq0iBFklJDAW0aJRdN5QWxhgVCJm2++sIHYIgLqEp937WQHsZkF
        pjJKvL6VC2KzCVhJTGxfBdbLK2AnsaXhAJjNIqAqMXvCdxYQW1QgQuLTg8OsEDWCEidnPgGL
        cwL1rnp2hQ1iprjErSfzmSBseYntb+cwgxwnITCZXWLTktVsEH+6SHR9usQIYQtLvDq+hR3C
        lpH4vxOkGaRhHaPE344XUN3bgV6e/A+q21rizrlfbCDvMwtoSqzfpQ8RdpS4/203GyRU+CRu
        vBWEOIJPYtK26dDA4pXoaBOCqFaT2LBsAxvM2q6dK5knMCrNQvLaLCTvzELyziyEvQsYWVYx
        iqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEJpbT/45/2sH49VLSIUYBDkYlHt6MP3JxQqyJ
        ZcWVuYcYJTiYlUR4T86QjRPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampB
        ahFMlomDU6qBsZhJrKk9co/C5zgJV7kfNYlNs5mkS7bNlf2/KURp5YMnXxzb6mJcdHq6brrJ
        7H/14IPF/iuL2eMy3SPqDt3bPFv++Luztzg2yyf11bn86SnRjahIUCuZ/WvJgesO71bw7THk
        cbOLXCMjWWF06/q0LjH/C5tXG2z3CtSc4NQh7nyMI0D4n7KpEktxRqKhFnNRcSIA0k3M4CgD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7qB+vJxBosa9SyufH3PZjH70Etm
        i3knJSxO9H1gtbi8aw6bA6vHzll32T3udx9n8vi8SS6AOUrPpii/tCRVISO/uMRWKdrQwkjP
        0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY/GBm2wFm7gqnq78yd7AeIyji5GDQ0LA
        ROLKL8MuRi4OIYGljBItU78yQsRlJI6vL+ti5AQyhSX+XOtig6h5zSix5cR5JpCEsECoxM03
        X9hAbBEBdYnPu3aygxQxC0xllJjQORFskJBAL6PEPB+QGjYBK4mJ7asYQWxeATuJLQ0HwGwW
        AVWJ2RO+s4DYogIREod3zIKqEZQ4OfMJWJwTqHfVsytgu5iBdv2Zd4kZwhaXuPVkPhOELS+x
        /e0c5gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbRtmM/
        t+xg7HoXfIhRgINRiYf3wD+5OCHWxLLiytxDjBIczEoivCdnyMYJ8aYkVlalFuXHF5XmpBYf
        YjQFem4is5Rocj4wxvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBK
        NTByySQL+rMpPc/71L/NOiCrv3Tl/hDz5t8+AqXn+X7rcC3MUlpkVsZ61iY8W32pvVJv0Ioj
        RYrqQg63z7z4JXolstqBtejCU723z1Zd3hiw5FHa977L4edu/heIrkpYnHXiFcOtK9beOuvD
        crViGM5wnLYxVDVrnsfSu0t17YKPgcGVceeTlimxFGckGmoxFxUnAgDtUQ/7uQIAAA==
X-CMS-MailID: 20200115152713eucas1p2708b37fefac03525989791e8f7094807
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191118080914eucas1p2fce1f43568b8453b9d513108df54f384
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191118080914eucas1p2fce1f43568b8453b9d513108df54f384
References: <CGME20191118080914eucas1p2fce1f43568b8453b9d513108df54f384@eucas1p2.samsung.com>
        <20191118080900.30634-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/18/19 9:09 AM, Chuhong Yuan wrote:
> The driver calls register_framebuffer in probe but does not call
> unregister_framebuffer in remove.
> Add the missed call to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/video/fbdev/s1d13xxxfb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
> index e04efb567b5c..162003ea6b79 100644
> --- a/drivers/video/fbdev/s1d13xxxfb.c
> +++ b/drivers/video/fbdev/s1d13xxxfb.c
> @@ -729,6 +729,7 @@ s1d13xxxfb_remove(struct platform_device *pdev)
>  	struct s1d13xxxfb_par *par = NULL;
>  
>  	if (info) {
> +		unregister_framebuffer(info);

s1d13xxxfb_remove() is not only called on removal operation but also
by s1d13xxxfb_probe() on register_framebuffer() failure. After above
change the code in s1d13xxxfb_probe() will break. The issue needs to
be fixed in different way, i.e.

- rename existing s1d13xxxfb_remove() to __s1d13xxxfb_remove()

- add s1d13xxxfb_remove() which does unregister_framebuffer() and
  then calls __s1d13xxxfb_remove())

>  		par = info->par;
>  		if (par && par->regs) {
>  			/* disable output & enable powersave */
> 

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
