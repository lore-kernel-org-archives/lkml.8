Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB649C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891C520772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y94+MSvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgFAITt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:19:49 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59059 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgFAITs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:19:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200601081947euoutp0148eae0efe2bc2be9ea219013a8d14ee3~UXbIEX1iX0273702737euoutp01F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:19:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200601081947euoutp0148eae0efe2bc2be9ea219013a8d14ee3~UXbIEX1iX0273702737euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590999587;
        bh=s3Ec/lKFroeeFCLe2u/iYci4hhYxXJEs5l6GyVdbeD4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Y94+MSvJceWl2X5Ixbl/oIvGj5FJsateM4dOqfXKqF7G9Sj5kt3cPYpes+l/Troi2
         72+23bFyg6A0HaZkIqg4HmFqJ9DfHHrTw0mjyJ5EyO4qkdeclW/jzEClIioMFrtKSj
         6Eqyd1+Qg4nMBcflmOStczyGOaz5mpPfX/cY0FZw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200601081947eucas1p16dc2db3eb04fa508f3a1be2f7cd67bb2~UXbHuG69y1270012700eucas1p15;
        Mon,  1 Jun 2020 08:19:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 90.C2.60698.32AB4DE5; Mon,  1
        Jun 2020 09:19:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200601081946eucas1p208442218e510398cacb83e4e08217bef~UXbHa-Fuq3257432574eucas1p2E;
        Mon,  1 Jun 2020 08:19:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200601081946eusmtrp1593276250b5abf23051607514e822098~UXbHaMPla2264822648eusmtrp1W;
        Mon,  1 Jun 2020 08:19:46 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-73-5ed4ba235d7f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id ED.B4.07950.22AB4DE5; Mon,  1
        Jun 2020 09:19:46 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200601081945eusmtip25475d48146a4203d6398e2ca580244df~UXbGSU20M2280122801eusmtip2Y;
        Mon,  1 Jun 2020 08:19:45 +0000 (GMT)
Subject: Re: [RFC PATCH v5 1/6] dt-bindings: exynos-bus: Add documentation
 for interconnect properties
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <e8e00988-af5d-7022-f66d-89a2cb0f74cf@samsung.com>
Date:   Mon, 1 Jun 2020 10:19:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529163200.18031-2-s.nawrocki@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+XbOzo6j2XFavpiZTYtU8oL9OJCsFINhGP0KstRmHqbmpmxe
        Wn9SRDNvmEreSrvMFDUvc4nM1FJLcl5AxTSNVS5FRULUxGaW2zHy3/O+7/PxXvhITDjJdSJj
        FUmMUiGNFxF8vP391uhpN/1EhG+JhksbqzIR3VrWzKU/ri9w6er+ES49sfGDoEu7tARdZCzE
        6dHRFh6tnZvk0uP6RwRdNtrNoV/2f+bRM+l1BJ3Z1c+jy4oXifMHJdr6+4RkdvI1ITHmDnAk
        bZq7kgJdPZKsaV0uE2H8gGgmPjaFUfqIb/BjJsfbUWLr4dvpi9koDTUIcxBJAnUGhnVeOciG
        FFJ1CBamnHMQf5fXEcxVt/HYYA3BdpqOY7EsD4ZqSzhsoRbBG/MmxgarCEZqx3CLZU/FQMfX
        fMzCDlQwZH2vwi0SRn3jwE5jJddSICg/yH9XgCwsoMSQ93zc2gKn3GFDu2PlQ1Q45BmXMNax
        gw/lJmsDGyoAmpcNVgejHOGTqXqPj0HGq0qMHXWLB/MaV5aDYbry6V7eHpYGdDyWncFQnGcd
        DqgMBHmdMzw2KERgHHiCWOsszI78IiwXwygPaNb7sOlAME01cdhD2sLUih07gy0UtZdibFoA
        2VlC1nYHc33p3hWdINf0By9Eoop9m1Xs26Zi3zYV//s+QXg9cmSSVXIZo/JXMKneKqlclayQ
        ed9MkGvR7m8z7AxsdKDu7aheRJFIdEBwamw8QsiVpqjU8l4EJCZyEAQNGyKEgmip+g6jTIhU
        Jsczql50hMRFjgL/Z4vhQkomTWJuMUwio/xX5ZA2Tmko0skUd84DCtUnfFKvBEWsttXyq7x+
        Rg369JUf737g2s1s9vXKltoeuptP1vjKWnKuumQ0fbnXM6SueWwOGV4jyFJF57pmTd0Y7/l7
        8yLdM5bMM4vdXJqv6Ru8+6+HwkZJWE+I2KBemb80zakRv0WJofKs+cEXRcvyC0cDM+JEuCpG
        6ueJKVXSv0Jw6cppAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xe7pKu67EGSw6aWBxf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12
        i9uNK9gsWvceYbeYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPvi2rGD0+b5ILYIvSsynK
        Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7h2eRtjwUax
        isaXHYwNjKuFuhg5OSQETCTOLJ/CBGILCSxllDj/LKqLkQMoLiUxv0UJokRY4s+1LjaIkveM
        EgcXqoLYwgIZEj17D4PFRQRcJNqezmPpYuTiYBZ4xCSxtKmPGcQREjjIKPH2yCV2kCo2AUOJ
        3qN9jCA2r4CdRM/iy2CLWQRUJL5u+gdmiwrESnQv/sEOUSMocXLmExYQm1PARmL969NgNcwC
        6hJ/5l1ihrDFJW49mQ8Vl5do3jqbeQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrF
        ibnFpXnpesn5uZsYgbG87djPLTsYu94FH2IU4GBU4uG9cP5ynBBrYllxZe4hRgkOZiURXqez
        p+OEeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YZvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7G
        CAmkJ5akZqemFqQWwfQxcXBKNTDW9PwIOPPpYPHDh/u2sc6YdfTX6lzNWwYrPm6NnrprHdM9
        fhsGTptTrx9HOTg93rmg8F/V/az4NZOTqr727q2oU9gyZ8/uc+YrNfOFlhhoxb5sEMtVvWz6
        qunA39TJL6+73XFq/CPwdsqKhTderayV/mghEmgY9Z7l/AJHq7brUV4PRO/eYE/dq8RSnJFo
        qMVcVJwIAIa1OQb7AgAA
X-CMS-MailID: 20200601081946eucas1p208442218e510398cacb83e4e08217bef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529163219eucas1p2d127fe3936921f53f6fe7902e7d14a3e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529163219eucas1p2d127fe3936921f53f6fe7902e7d14a3e
References: <20200529163200.18031-1-s.nawrocki@samsung.com>
        <CGME20200529163219eucas1p2d127fe3936921f53f6fe7902e7d14a3e@eucas1p2.samsung.com>
        <20200529163200.18031-2-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Rob, devicetree ML

On 29.05.2020 18:31, Sylwester Nawrocki wrote:
> Add documentation for new optional properties in the exynos bus nodes:
> samsung,interconnect-parent, #interconnect-cells.
> These properties allow to specify the SoC interconnect structure which
> then allows the interconnect consumer devices to request specific
> bandwidth requirements.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v5:
>  - exynos,interconnect-parent-node renamed to samsung,interconnect-parent
> ---
>  Documentation/devicetree/bindings/devfreq/exynos-bus.txt | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> index e71f752..e0d2daa 100644
> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> @@ -51,6 +51,11 @@ Optional properties only for parent bus device:
>  - exynos,saturation-ratio: the percentage value which is used to calibrate
>  			the performance count against total cycle count.
> 
> +Optional properties for interconnect functionality (QoS frequency constraints):
> +- samsung,interconnect-parent: phandle to the parent interconnect node; for
> +  passive devices should point to same node as the exynos,parent-bus property.
> +- #interconnect-cells: should be 0
> +
>  Detailed correlation between sub-blocks and power line according to Exynos SoC:
>  - In case of Exynos3250, there are two power line as following:
>  	VDD_MIF |--- DMC
> @@ -185,8 +190,9 @@ Example1:
>  	----------------------------------------------------------
> 
>  Example2 :
> -	The bus of DMC (Dynamic Memory Controller) block in exynos3250.dtsi
> -	is listed below:
> +	The bus of DMC (Dynamic Memory Controller) block in exynos3250.dtsi is
> +	listed below. An interconnect path "bus_lcd0 -- bus_leftbus -- bus_dmc"
> +	is defined for demonstration purposes.
> 
>  	bus_dmc: bus_dmc {
>  		compatible = "samsung,exynos-bus";
> @@ -376,12 +382,15 @@ Example2 :
>  	&bus_dmc {
>  		devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>  		vdd-supply = <&buck1_reg>;	/* VDD_MIF */
> +		#interconnect-cells = <0>;
>  		status = "okay";
>  	};
> 
>  	&bus_leftbus {
>  		devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>  		vdd-supply = <&buck3_reg>;
> +		samsung,interconnect-parent = <&bus_dmc>;
> +		#interconnect-cells = <0>;
>  		status = "okay";
>  	};
> 
> @@ -392,6 +401,8 @@ Example2 :
> 
>  	&bus_lcd0 {
>  		devfreq = <&bus_leftbus>;
> +		samsung,interconnect-parent = <&bus_leftbus>;
> +		#interconnect-cells = <0>;
>  		status = "okay";
>  	};
> 
> --
> 2.7.4
