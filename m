Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C18C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA5720772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kDz+S3Ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgGHMZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:25:26 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11105 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgGHMZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:25:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f05bb280000>; Wed, 08 Jul 2020 05:25:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 08 Jul 2020 05:25:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 08 Jul 2020 05:25:25 -0700
Received: from [10.26.73.185] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 12:25:18 +0000
Subject: Re: [PATCH v10 4/5] dt-bindings: arm-smmu: add binding for Tegra194
 SMMU
To:     Krishna Reddy <vdumpa@nvidia.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robh+dt@kernel.org>,
        <treding@nvidia.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <yhsu@nvidia.com>,
        <snikam@nvidia.com>, <praithatha@nvidia.com>, <talho@nvidia.com>,
        <bbiswas@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, <bhuntsman@nvidia.com>,
        <nicoleotsuka@gmail.com>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-5-vdumpa@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ec06de3c-fefa-eaa4-3498-abd1eb0d78d7@nvidia.com>
Date:   Wed, 8 Jul 2020 13:25:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708050017.31563-5-vdumpa@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594211113; bh=Xzfh1NzVG82EwW/mARDUWZypAGHmKQgo0WIQYqHsKDc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kDz+S3TyRCG/4o8mz/Uk2mGnf3f30lnrD7KF8Wc1wtV3O/HdkAksX5kzf65vfE4yi
         MnGesmon47DGmcHNIK/k2ypEnPSRbsyXzgwtuXtILxzo4je3d6P6qd44It9+GEL9z+
         kE2H6+wZwwlC2R/Ois07laWv8TCk50ec4JPXn8bk7ZSe+Brhkq9rsoFl1UBxBSKO0G
         7MYo3dBr5w03ywKutHN3eQ1Lu0nVlel7ZEt8w1lfx4AHZdD/NAzx6bsXIAjc/JidE7
         69PlMytZhtkS5fxgBxm5KPfYwsRCXBZa0auLfK9UDDZSSpoWx+N6dR3Y2y2ZD2oExN
         2c9I9k5UVGXzg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/07/2020 06:00, Krishna Reddy wrote:
> Add binding for NVIDIA's Tegra194 SoC SMMU.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index d7ceb4c34423..ac1f526c3424 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -38,6 +38,11 @@ properties:
>                - qcom,sc7180-smmu-500
>                - qcom,sdm845-smmu-500
>            - const: arm,mmu-500
> +      - description: NVIDIA SoCs that program two ARM MMU-500s identically
> +        items:
> +          - enum:
> +              - nvidia,tegra194-smmu
> +          - const: nvidia,smmu-500
>        - items:
>            - const: arm,mmu-500
>            - const: arm,smmu-v2
> @@ -138,6 +143,19 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra194-smmu
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 2
> +
>  examples:
>    - |+
>      /* SMMU with stream matching or stream indexing */
> 

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic
