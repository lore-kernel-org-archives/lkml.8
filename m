Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDF0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D51220870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UzN//N9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgGCSrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 14:47:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47358 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgGCSrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 14:47:25 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200703184722euoutp016b1500a15adcef50bf201a8eb573c647~eUoN-gn8E2953829538euoutp01D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 18:47:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200703184722euoutp016b1500a15adcef50bf201a8eb573c647~eUoN-gn8E2953829538euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593802042;
        bh=i1/uMDs8BgSjlm9bkstKj5YuscCvOGSa3GwGD5PZpt4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UzN//N9y9ROTSnLGmoAzyFEWZM52vP6mxMwapCl/V99Yn+LQaR2rH3QNVGyZfraH0
         J7Aspe2mQZ/IK2s0ieuweoPDXGLkBPM2GCQsj4NqX+Hc+gc315tTw6QKnoh6wNwL34
         Svs9kVHPg+NKYIMGThxtBevOBqx7kxNVITsYzBhw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200703184722eucas1p22fcca6dd07e52aaf1251e85fc18db7b3~eUoNiCsmr2016720167eucas1p2s;
        Fri,  3 Jul 2020 18:47:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1B.66.06318.A3D7FFE5; Fri,  3
        Jul 2020 19:47:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200703184721eucas1p14d55ad6733d8edbc22237da65563d0bc~eUoNGzc-m0218502185eucas1p1M;
        Fri,  3 Jul 2020 18:47:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200703184721eusmtrp2050d75dc1546f772412a0fa8183e36e2~eUoNGI9Qp1186411864eusmtrp2a;
        Fri,  3 Jul 2020 18:47:21 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-d5-5eff7d3ab566
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C2.0E.06017.93D7FFE5; Fri,  3
        Jul 2020 19:47:21 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200703184720eusmtip1f6a015963e019e47265fe8d15eb9bcc8~eUoML1gIE3172131721eusmtip10;
        Fri,  3 Jul 2020 18:47:20 +0000 (GMT)
Subject: Re: [PATCH 3/8] ASoC: samsung: pcm: fix kernel-doc
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <d6980967-5def-58c9-39a9-239a5c671f3f@samsung.com>
Date:   Fri, 3 Jul 2020 20:47:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702165901.164100-4-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvTPT6XS05FIwnKDBWDGuoAQwoyjBLRnjg/hmVKpFBkpY7QBu
        IRoRhKJ1i0GbCkTDYo0BK4JgRAWFVCJYtxA3AqlEidUIBQUFdDoaefv+c89/z/1PLkNqHisC
        meT0LMGYrk/V0ixV3zbaFbIqd1K3fHgYcy+cLQR3vtdFc11dtUpu5EUhwT1vstJcUdMpBTc2
        2U9wzmoPwdV+v464Tzc/EzEsXzt0lOYbLe+UvN1WRPOljq18s7uS5s11NsTX1L2k+Jsdh/gh
        e1Csaju7OkFITc4RjMuid7OGHx/CMsum77/27gw6giYYE2IYwBGQf583IZbR4GoEefX5pCw8
        CDrNfUpZDCE49uoXbUIqr6PiQj8psQZXIXCbl8r8DcGg009iPxwFbQUVSon9sQ6qPF3ei0hc
        QEDr1wGvmcZhcPKRGUmsxtFQYp2gJKZwMLy2Wr08E8eBuaKclnt8wXHR5a2r8GYYv+RUSEzi
        AHjtKiNkngMNbqs3AmC3Ep7elQcA3gCD46OUzH4w0F6nlHk2TDZKZsmQh+DEnTdKWZxG0NNe
        /tcdBW87x2hpYyReBDVNy+TyWhhvKCXkRfpAt9tXfoQPnK0vIeWyGgoLNHJ3MPy0lRAyB0Kx
        a5I6jbSWKdEsU+JYpsSx/J9bjigbChCyxbQkQQxPF/aFivo0MTs9KXRPRpod/flhHRPtw7dR
        86/4FoQZpJ2h/ugY12kU+hzxQFoLAobU+qvXPenQadQJ+gMHBWPGLmN2qiC2oFkMpQ1Qh1/+
        FKfBSfosIUUQMgXjv1OCUQUeQZHxPolxa5bYG2Jj2noLot9fhkjPtYjE6odrTQNjD66kLDTl
        Vs61t4Y1r0y+FxS14ELl4WDu5NWBPkMEu/HLFp1z7/VYbeXx+fMyc3uUNQu7DVmLVuxo7B25
        u7N4TlnO9+dbp52L9OT9DB8NUq3bEL+JvcXGhDi4HaBYf+PZzvptfdO1lGjQhy0mjaL+N+Dn
        NktdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xu7qWtf/jDN4cMLC4cvEQk8XUh0/Y
        LM6f38Bu8e1KB5PF5V1z2Cw6d/WzWvz6/4zJ4uKKL0wWG76vZbR4ufkNkwOXx4bPTWweO2fd
        ZffYtKqTzWPeyUCPfW+XsXn0bVnF6LF+y1UWj82nqz0+b5IL4IzSsynKLy1JVcjILy6xVYo2
        tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy/jx1LBgPnfF6rsTGRsY/3F0MXJy
        SAiYSCyd8Yy5i5GLQ0hgKaPEzcud7F2MHEAJKYn5LUoQNcISf651sUHUvGeUuL/0ETNIQljA
        WuJY21J2EFtEIE5i98JDLCBFzAJtTBLfV/UwQnTcZ5T40NPDBFLFJmAo0Xu0jxHE5hWwk5g+
        5x8LiM0ioCJxa84cMFtUIFbi270tbBA1ghInZz4Bi3MKeEv8nXuRFcRmFlCX+DPvEjOELS5x
        68l8JghbXmL72znMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P
        3cQIjNttx35u2cHY9S74EKMAB6MSD++E43/jhFgTy4orcw8xSnAwK4nwOp09HSfEm5JYWZVa
        lB9fVJqTWnyI0RTouYnMUqLJ+cCUklcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1
        ILUIpo+Jg1OqgXGS45/DembLlq7r1rganz5j7YfASN4sLu/rEjc3t+t6eXI/dpK/v+q6r0fy
        jlKzZJ1Z07yrJhzcbnO0aq2El6bYb/5CoVP2TvN33pyw8HBKtaLytWd3Zhp2PC2O3Lakvf5s
        p6+ofHeh6h+dhPYvX0tcmcr/2y/Sy1mjlnav8eO3Xef8ntfu9lJiKc5INNRiLipOBADTRFEi
        8QIAAA==
X-CMS-MailID: 20200703184721eucas1p14d55ad6733d8edbc22237da65563d0bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200702165920eucas1p236c3c4c82424ea459ea88ebacf9b8a6e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200702165920eucas1p236c3c4c82424ea459ea88ebacf9b8a6e
References: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
        <CGME20200702165920eucas1p236c3c4c82424ea459ea88ebacf9b8a6e@eucas1p2.samsung.com>
        <20200702165901.164100-4-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.2020 18:58, Pierre-Louis Bossart wrote:
> Fix W=1 warnings - missing fields in structure
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/samsung/pcm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
> index a5b1a12b3496..86eefbc89e9e 100644
> --- a/sound/soc/samsung/pcm.c
> +++ b/sound/soc/samsung/pcm.c
> @@ -104,8 +104,13 @@

Thank you for the patch, I have some suggestions to improve the comments.

>  /**
>   * struct s3c_pcm_info - S3C PCM Controller information
> + * @lock: Spin lock

@lock: Spin lock to serialize access to the device registers and @idle_clk

>   * @dev: The parent device passed to use from the probe.
>   * @regs: The pointer to the device register block.
> + * @sclk_per_fs: number of sclk per frame sync
> + * @idleclk: Whether to keep PCMSCLK enabled even when idle(no active xfer)

How about adding space before the opening parenthesis?

> + * @pclk: the pclk pointer

@pclk: the PCLK_PCM (pcm) clock pointer

> + * @cclk: the clck pointer

@cclk: the SCLK_AUDIO (audio-bus) clock pointer  

>   * @dma_playback: DMA information for playback channel.
>   * @dma_capture: DMA information for capture channel.
>   */
 
With above changes feel free to add:
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
Thanks,
Sylwester
