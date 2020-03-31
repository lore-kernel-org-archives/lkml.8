Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE97C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33A7206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Mw0z391+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgCaFnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 01:43:33 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35465 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgCaFnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 01:43:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200331054331euoutp018c301d8fb1960bc8187687ec2c96da39~BTS_z39TX0427204272euoutp01G
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 05:43:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200331054331euoutp018c301d8fb1960bc8187687ec2c96da39~BTS_z39TX0427204272euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585633411;
        bh=hJcKcQ3DnvBge/w5XUhJjy7OPv6SY/USHjq4j46m/Dw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Mw0z391+E3m4w0GGyruTOVPuUUUeRf3hNvQPegV12reowNscGP7v9Ao4E+MAVCHi4
         4/5hbAjppuSRHD41fR1WRVUIdyIXPD5MDYv8qI5GUef7QpMKYbV9p/SsJHmu1a0VCi
         ol9Jdedi8h1tdm5g6yoi6RsVbJM9dOBP2YLiPlzU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200331054330eucas1p228f8d59afa161a72c7a6bca41acad318~BTS_pypL32030220302eucas1p2U;
        Tue, 31 Mar 2020 05:43:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FD.AE.60679.288D28E5; Tue, 31
        Mar 2020 06:43:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200331054330eucas1p1820bb2b039a93d7996634f09a09b6bc6~BTS_KU0tF2789627896eucas1p1V;
        Tue, 31 Mar 2020 05:43:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200331054330eusmtrp137d971475018bd66997e72b05070f526~BTS_JxrQf2056420564eusmtrp1Z;
        Tue, 31 Mar 2020 05:43:30 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-9d-5e82d882d8fc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 47.F8.07950.288D28E5; Tue, 31
        Mar 2020 06:43:30 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200331054329eusmtip2d1f35445c2d79d61aa3986530fdeda46~BTS9yJckR1259412594eusmtip2W;
        Tue, 31 Mar 2020 05:43:29 +0000 (GMT)
Subject: Re: [PATCH v1] driver core: Fix handling of fw_devlink=permissive
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <781eefdc-c926-7566-5305-bb9633e6fac0@samsung.com>
Date:   Tue, 31 Mar 2020 07:43:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331022832.209618-1-saravanak@google.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7pNN5riDE51m1k0L17PZrFju4jF
        5V1z2CzmfpnKbNF16C+bA6vHtt3bWD0WbCr12LSqk81j/9w17B6fN8kFsEZx2aSk5mSWpRbp
        2yVwZZx9ql/wRahi2ePNLA2M8/m7GDk5JARMJO6e3s4GYgsJrGCU2N9fCGF/YZRY8Keii5EL
        yP7MKHH8UA8zTMPktX9ZIRLLGSXefF3IAuG8Z5TY1PGBCaRKWMBLonPnHbAqEYE2RomH+36y
        gCSYBSwlXq2ZwwpiswkYSnS97QLbzStgJ9H8ZgMjiM0ioCpx8/oLMFtUIEbi4uF+VogaQYmT
        M58AzeHg4BSwltjTIQ8xUl5i+9s5zBC2uMStJ/OZQPZKCExnl9g7fzo7xNkuEoc3vIB6QVji
        1fEtUHEZidOTe1ggGpqBDj23lh3C6WGUuNw0gxGiylrizrlfbCCbmQU0Jdbv0ocIO0q8+dwA
        FpYQ4JO48VYQ4gg+iUnbpjNDhHklOtqEIKrVJGYdXwe39uCFS8wTGJVmIflsFpJ3ZiF5ZxbC
        3gWMLKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzECE83pf8e/7GDc9SfpEKMAB6MSD++D
        q41xQqyJZcWVuYcYJTiYlUR42fwb4oR4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5Y
        kpqdmlqQWgSTZeLglGpgXJ39abKn5dG3J9bt0Xe6zFp9eLPtk6WpO/tcu2NnfNfbKeoZtEKv
        o/8Vj9L1xayFpn35m+UFzhxgN1vMq7Q+Y556d0PRzLWml5MFi0XEpv2/OvGtxtk/ho8eczcs
        uH5EP3iSnU6Q70OfxO3TTXZmmG3cv36b68f1/+fmf8+MUT04/93plDcLdiixFGckGmoxFxUn
        AgAEGdnOMAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xe7pNN5riDA5/EbFoXryezWLHdhGL
        y7vmsFnM/TKV2aLr0F82B1aPbbu3sXos2FTqsWlVJ5vH/rlr2D0+b5ILYI3SsynKLy1JVcjI
        Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQyzj7VL/gi1DFssebWRoY
        5/N3MXJySAiYSExe+5e1i5GLQ0hgKaPEp1cr2SASMhInpzWwQtjCEn+udbFBFL1llNi0fh0j
        SEJYwEuic+cdsG4RgQ5GiW9Xr4N1MwtYSrxaMwdqbB+jRP/ra8wgCTYBQ4mut11gRbwCdhLN
        bzaATWIRUJW4ef0FmC0qECPxc08XC0SNoMTJmU+AbA4OTgFriT0d8hDzzSTmbX7IDGHLS2x/
        OwfKFpe49WQ+0wRGoVlIumchaZmFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcx
        AqNr27GfW3Ywdr0LPsQowMGoxMP74GpjnBBrYllxZe4hRgkOZiURXjb/hjgh3pTEyqrUovz4
        otKc1OJDjKZAv01klhJNzgdGfl5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQi
        mD4mDk6pBkahxGe/A8SKTJ4dLrY7bHn/7ewd+kvTP/350lkT/eDM1pmLrA72q3M3rrkrOKWk
        lqNKy37DxBjdXhu+QjMWfu7m/+ZK6qUsGiG2/548enP0qu6b7qTr7nc0TRvKXZeyGc+b9Vn0
        rIJSFNvdBRunt7p0F/E/3RU4Lb7F07LtjFAi83Wfu+n21kosxRmJhlrMRcWJALdHkbzEAgAA
X-CMS-MailID: 20200331054330eucas1p1820bb2b039a93d7996634f09a09b6bc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200331022842eucas1p29e52dc93c4bd0b6e470c41aef19c9a86
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200331022842eucas1p29e52dc93c4bd0b6e470c41aef19c9a86
References: <CGME20200331022842eucas1p29e52dc93c4bd0b6e470c41aef19c9a86@eucas1p2.samsung.com>
        <20200331022832.209618-1-saravanak@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020-03-31 04:28, Saravana Kannan wrote:
> When commit 8375e74f2bca ("driver core: Add fw_devlink kernel
> commandline option") added fw_devlink, it didn't implement "permissive"
> mode correctly.
>
> That commit got the device links flags correct to make sure unprobed
> suppliers don't block the probing of a consumer. However, if a consumer
> is waiting for mandatory suppliers to register, that could still block a
> consumer from probing.
>
> This commit fixes that by making sure in permissive mode, all suppliers
> to a consumer are treated as a optional suppliers. So, even if a
> consumer is waiting for suppliers to register and link itself (using the
> DL_FLAG_SYNC_STATE_ONLY flag) to the supplier, the consumer is never
> blocked from probing.
>
> Fixes: 8375e74f2bca ("driver core: Add fw_devlink kernel commandline option")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Hi Marek,
>
> If you pull in this patch and then add back in my patch that created the
> boot problem for you, can you see if that fixes the boot issue for you?

Indeed, this fixes booting on my Raspberry Pi3/4 boards with linux 
next-20200327. Thanks! :)

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

>
> Thanks,
> Saravana
>
>   drivers/base/core.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5e3cc1651c78..1be26a7f0866 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2370,6 +2370,11 @@ u32 fw_devlink_get_flags(void)
>   	return fw_devlink_flags;
>   }
>   
> +static bool fw_devlink_is_permissive(void)
> +{
> +	return fw_devlink_flags == DL_FLAG_SYNC_STATE_ONLY;
> +}
> +
>   /**
>    * device_add - add device to device hierarchy.
>    * @dev: device.
> @@ -2524,7 +2529,7 @@ int device_add(struct device *dev)
>   	if (fw_devlink_flags && is_fwnode_dev &&
>   	    fwnode_has_op(dev->fwnode, add_links)) {
>   		fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
> -		if (fw_ret == -ENODEV)
> +		if (fw_ret == -ENODEV && !fw_devlink_is_permissive())
>   			device_link_wait_for_mandatory_supplier(dev);
>   		else if (fw_ret)
>   			device_link_wait_for_optional_supplier(dev);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

