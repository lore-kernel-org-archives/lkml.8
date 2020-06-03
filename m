Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD6FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5AD207DA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H9LoR8cE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgFCKEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:04:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51753 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgFCKEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:04:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200603100435euoutp02abb24cc1b219e5dc6c6632f95848f205~VAJM51a_Y1947419474euoutp02u
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:04:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200603100435euoutp02abb24cc1b219e5dc6c6632f95848f205~VAJM51a_Y1947419474euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591178675;
        bh=bTtM3f6fJX0XJc/AZMw05HmVFiL4CAKhheZtdCnnwh8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=H9LoR8cELPQFLsaQxOF1BohOqHriYmVxte5mZyAkPqUFTsZQ/LVHKdpHy7NsADtvf
         NYUdv6hTzabKDdVExzSut749iXbIDKi6gLtEcCKUtzceyQwZnTjCRH10fp5sIFuUkf
         dlvXe2UNSFGrhlkSmBM86fkIrfsIrf9lSBa73VXA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200603100435eucas1p1678fb1d5d07ee79cde2a655b455467d8~VAJMd8_Ld2261522615eucas1p12;
        Wed,  3 Jun 2020 10:04:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5D.BA.61286.3B577DE5; Wed,  3
        Jun 2020 11:04:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200603100434eucas1p1adcbd0786f417dbe86e3f5296eedecf3~VAJMF5ZGo2257822578eucas1p1Q;
        Wed,  3 Jun 2020 10:04:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200603100434eusmtrp112543989f7bbf9339d7e28d73749744c~VAJMFBNEg1896818968eusmtrp1R;
        Wed,  3 Jun 2020 10:04:34 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-e1-5ed775b36a28
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EF.F3.08375.2B577DE5; Wed,  3
        Jun 2020 11:04:34 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200603100433eusmtip1e3bc175fe1d9024663c6fe0adc6454b9~VAJLMA65s1744617446eusmtip1w;
        Wed,  3 Jun 2020 10:04:33 +0000 (GMT)
Subject: Re: [RFC PATCH v5 6/6] drm: exynos: mixer: Add interconnect support
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     georgi.djakov@linaro.org, krzk@kernel.org, a.swigon@samsung.com,
        myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <bc921707-2623-b868-023c-1a0b759bc7c6@samsung.com>
Date:   Wed, 3 Jun 2020 12:04:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <7e42706f-2e69-79a6-d138-f2aa5e800270@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0iTYRTGeb/bPqXZ67Q8aBkNowvkpRl8UJlFySSpQX90Aa2VH85yGpvO
        lChFylxqoshy3YZpykK0aVZaBmItUZulTilroEJ5KfNWZJRt+5T873fOeR7Oc15elpR00f5s
        YnIqr0lWJkkZT6rx1a83W+vT+uNCm9ppznHnMuIe3qiluf7ZzzTXOzfJcIbnFoYrdhRRnM1W
        J+Isw3aa62m6xXA3bC0EV9P2UcR9yK52liWjTKRYbjHnMfJB+zNG7rhmJeT1FZfkhQ1mJJ+x
        BCqY45474/mkRB2vCYk46aka/7bxXCWcz7M9JbJQu48eebCAw6FZ/wK5WIKrEVypidQjTyfP
        Iuivm2WEYgbBhKOXXnK0lXfTwqAKwcz9Z6RQTCH4aR4SuVQ+OAaGO+2ki33xJij704tcIhLb
        CJjI1hOuAYPDoOBloXu5GEdAd2m220DhIBgYz3PzKhwL+Y4xUtB4Q3vZCOViD7wbTA8c7kgk
        9oP3I3cJgddBzqOb7kSAh0RgmTcSQu598Li5GQnsA2PWBpHAa6CjJJ8SDDkI8ps/iISiCIHD
        alp07IDBN/PO52CdKzZDbVOI0N4DPdcLaFcbsBcMfPUWQnhBcaOBFNpiuHpFIqiD4LfZsBjH
        H66NLFBFSGpcdppx2TnGZecY/+81IcqM/Pg0rTqB14Yl8+nBWqVam5acEHw6RW1Bzk/W8dc6
        /QTNvTvVijCLpCvEoWH2OAmt1Gkz1K0IWFLqK97b1REnEccrMzJ5TcoJTVoSr21FASwl9RPL
        ykdjJThBmcqf5flzvGZpSrAe/lnIlBsef+aQY6S6St+3Jnd/YJ7lYkxL39FCPCH7nllq0BVE
        k8wfBbUr5gI5R4xFh0xGFb82SRXret9W163foZI91UV0fuEP3yYVAfGrV05VFatGDwxGHVOl
        r/0U9EOWWJOqk8b6V35jc+x75u8tnKnYFot/H9zeuSHziDfVPTldKaW0KmXYFlKjVf4DwDNq
        IGADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xu7qbSq/HGczerWdxf14ro8XGGetZ
        La5/ec5qceXrezaL6Xs3sVlMuj+BxeL8+Q3sFpseX2O1uLxrDpvFjPP7mCzWHrnLbnG7cQWQ
        O/klmwOvx6ZVnWwed67tYfO4332cyWPzknqPvi2rGD0+b5ILYIvSsynKLy1JVcjILy6xVYo2
        tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy3j9Tr1gqURF5/mdTA2MJ4W7GDk5
        JARMJI4susDaxcjFISSwlFFi+umvzF2MHEAJKYn5LUoQNcISf651sUHUvGeUWH63mwUkISzg
        I/H4zDVmEFtEQENi5t8rjCA2s8B5Jok3TTwQDd8YJWa9WwJWxCZgKNF7tA+siFfATuLC1Eaw
        OIuAisSN151gtqhArET34h/sEDWCEidnPgFbxilgL7Fg9X1WiAXqEn/mXWKGsMUlbj2ZzwRh
        y0s0b53NPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwLjd
        duzn5h2MlzYGH2IU4GBU4uE1MLwWJ8SaWFZcmXuIUYKDWUmE1+ns6Tgh3pTEyqrUovz4otKc
        1OJDjKZAz01klhJNzgemlLySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1M
        HJxSDYzsXgl/jM5bs/AVnnhnbMT/6FETl/aqlRyL1otOu7+llecGY+vv4rVspqcmRZ9zTIsK
        2KYx/XD8hXKZ3O9XWC33d55j5k6clPrp2fQOiZbw8Gf7r4d3i4odfceVc6k7ry5BYMKXAwu7
        tbkD550wlffakR3zS/IGk0nKAnsNMQHTUKEiodV3fimxFGckGmoxFxUnAgAvxdln8QIAAA==
X-CMS-MailID: 20200603100434eucas1p1adcbd0786f417dbe86e3f5296eedecf3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529163229eucas1p2ee6394f184e5eba12599559f8a621fde
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529163229eucas1p2ee6394f184e5eba12599559f8a621fde
References: <20200529163200.18031-1-s.nawrocki@samsung.com>
        <CGME20200529163229eucas1p2ee6394f184e5eba12599559f8a621fde@eucas1p2.samsung.com>
        <20200529163200.18031-7-s.nawrocki@samsung.com>
        <7e42706f-2e69-79a6-d138-f2aa5e800270@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 01.06.2020 09:58, Chanwoo Choi wrote:
> On 5/30/20 1:32 AM, Sylwester Nawrocki wrote:
>> From: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>> This patch adds interconnect support to exynos-mixer. The mixer works
>> the same as before when CONFIG_INTERCONNECT is 'n'.
>>
>> For proper operation of the video mixer block we need to ensure the
>> interconnect busses like DMC or LEFTBUS provide enough bandwidth so
>> as to avoid DMA buffer underruns in the mixer block. i.e we need to
>> prevent those busses from operating in low perfomance OPPs when
>> the mixer is running.
>> In this patch the bus bandwidth request is done through the interconnect
>> API, the bandiwidth value is calculated from selected DRM mode, i.e.
>> video plane width, height, refresh rate and pixel format.
>>
>> Co-developed-by: Artur Świgoń <a.swigon@samsung.com>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> [s.nawrocki: renamed soc_path variable to icc_path, edited commit desc.]
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

>>  drivers/gpu/drm/exynos/exynos_mixer.c | 73 ++++++++++++++++++++++++++++++++---
>>  1 file changed, 68 insertions(+), 5 deletions(-)
  
>> +static void mixer_set_memory_bandwidth(struct exynos_drm_crtc *crtc)
>> +{
>> +	struct drm_display_mode *mode = &crtc->base.state->adjusted_mode;
>> +	struct mixer_context *ctx = crtc->ctx;
>> +	unsigned long bw, bandwidth = 0;
>> +	u32 avg_bw, peak_bw;
>> +	int i, j, sub;
>> +
>> +	if (!ctx->icc_path)
>> +		return;
>> +
>> +	for (i = 0; i < MIXER_WIN_NR; i++) {
>> +		struct drm_plane *plane = &ctx->planes[i].base;
>> +		const struct drm_format_info *format;
>> +
>> +		if (plane->state && plane->state->crtc && plane->state->fb) {
>> +			format = plane->state->fb->format;
>> +			bw = mode->hdisplay * mode->vdisplay *
>> +							drm_mode_vrefresh(mode);
>> +			if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>> +				bw /= 2;
>> +			for (j = 0; j < format->num_planes; j++) {
>> +				sub = j ? (format->vsub * format->hsub) : 1;
>> +				bandwidth += format->cpp[j] * bw / sub;
> 
> First of all, I agree this approach.
> 
> Could you please add more detailed comments for understadning
> about this calculation? As you commented, it seems that
> the final bandwidth contains the width/height/refresh rate
> and pixel format. If you add one real example, it will be very helpful.

OK, I will improve the commit message and add a comment to the function.
As far as I understand this simply calculates amount of data in bytes that
needs to be read from the system memory per second for given video stream,
by summing values for each mixer window and for each color plane within 
a window.

Anyway, the patch will to be changed as after some more tests it seems
the calculation works for LEFTBUS but DMC clock on Odroid U3 needs to
be set to 400 MHz, rather than to at least 160 MHz. With any lower value 
the mixer underflow error interrupts are being triggered and eventually 
the IOMMU page fault occurs.

--
Regards,
Sylwester
