Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87662C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 00:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A3EF206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 00:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cHb36mQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHNAe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 20:34:27 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:43869 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHNAe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 20:34:26 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200814003421epoutp0423ec9ee6ea038489644ff260823471bc~q_z3rCOE10500205002epoutp04e
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 00:34:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200814003421epoutp0423ec9ee6ea038489644ff260823471bc~q_z3rCOE10500205002epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597365261;
        bh=a4Vq6CqPM+IzwnieurO9inOz861rMmOfAOArONcTU/4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cHb36mQpfmZYYJ8qllNlVzET4ZYMNY/iy86RSgtPggBkKbkU9o4wCd+YbjMNNPEoo
         CsaJ5zmhgdOW56CU5wLW/Jj/nRAJlF7LsKF/6Qh2Xi2MK3U/q6j+0ctpmhc/yA0MqA
         6HM4NL7PyLB0u0/UdXs4O9nY7oxt09EHU1IpXvSY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200814003420epcas1p42dc204364950d5ba0305a9ee7c12d6bd~q_z3DSawg1218512185epcas1p4U;
        Fri, 14 Aug 2020 00:34:20 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.155]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BSPZc0phgzMqYkg; Fri, 14 Aug
        2020 00:34:16 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.39.28581.70CD53F5; Fri, 14 Aug 2020 09:34:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200814003415epcas1p3fb798e831cfbab79c28e6dca8cdc8959~q_zx7KUrf1378113781epcas1p3B;
        Fri, 14 Aug 2020 00:34:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200814003415epsmtrp2a885e1bb1aadc63b481f6092533d0b02~q_zx6b4eg2147921479epsmtrp21;
        Fri, 14 Aug 2020 00:34:15 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-4e-5f35dc07ec3a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.36.08303.60CD53F5; Fri, 14 Aug 2020 09:34:14 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200814003414epsmtip2bced5523bc890427eb0b0881ef8a15cb~q_zxo4ukr3252132521epsmtip2w;
        Fri, 14 Aug 2020 00:34:14 +0000 (GMT)
Subject: Re: [PATCH v3] clk: samsung: Prevent potential endless loop in the
 PLL set_rate ops
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-clk@vger.kernel.org
Cc:     tomasz.figa@gmail.com, sboyd@kernel.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <28cd3eeb-816d-b369-11a9-16cd2c1af87c@samsung.com>
Date:   Fri, 14 Aug 2020 09:46:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200813095508.7563-1-s.nawrocki@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmri7HHdN4g1/TGS02zljPavGx5x6r
        xeVdc9gsZpzfx2Sx9shddouLp1wtDr9pZ7X4d20ji8WqXX8YHTg93t9oZffYOesuu8emVZ1s
        Hn1bVjF6fN4kF8AalW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
        4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85
        P9fK0MDAyBSoMCE748OFOcwF0ywrrtw7xN7AuEW3i5GTQ0LARGLR7fXsXYxcHEICOxglXhy6
        ygrhfGKUWPdoIQuE85lRYmf/V3aYltZVfWwQiV2MEtMmPIVqec8ocXbvAjaQKmGBOInlM9Yy
        dTFycIgIeEnMa9AFqWEW2Mso0f74H1gNm4CWxP4XN8BsfgFFias/HjOC2LwCdhKLZh4Di7MI
        qEps3H2KFcQWFQiTOLmtBapGUOLkzCcsIDangLXEjdvLmEFsZgFxiVtP5jNB2PIS29/OYQZZ
        LCGwkkPicU8/C8QLLhK3Px9gg7CFJV4d3wL1mpTE53d7oeLVEitPHmGDaO5glNiy/wIrRMJY
        Yv/SyWCfMQtoSqzfpQ8RVpTY+XsuI8RiPol3X3tYQUokBHglOtqEIEqUJS4/uMsEYUtKLG7v
        ZJvAqDQLyTuzkLwwC8kLsxCWLWBkWcUollpQnJueWmxYYIIc3ZsYwYlVy2IH49y3H/QOMTJx
        MB5ilOBgVhLhZb5sHC/Em5JYWZValB9fVJqTWnyI0RQYwBOZpUST84GpPa8k3tDUyNjY2MLE
        0MzU0FBJnPfhLYV4IYH0xJLU7NTUgtQimD4mDk6pBia9LVvqMkxDHm/Y4cN4r0PB7PDd3FnC
        Gpcs60sLDa9tK6389SjQtXKfT0DB/ZDLJbkbX5RqLoyz+BH37O/Sp5+f290sToi4Lnol9tjz
        5wmvVNd2Rfz6aOm/cItOyIPXmpVJZ/5r5bwTe+Yesv+rznxnt957i+1yJu+eO0Mjb5qFE3Nu
        BJvq0U+83Sw7AzdNNdA6EKK07v9q8296+a++bxNQbrkT9zXp/j3nKoEvS7RvhYoGz+Dr5fuy
        sm6KXWC2/OJLF4qi7V0zUo5+Z14i0NHs/mirwMYz24z9P/35G+js9CLkxKeVKXeXZ0pOyDSy
        7fkkdeR54zu9Gb/mpj25MnmiLGdAyK4K5/d3oicukY9WYinOSDTUYi4qTgQAJkZt/DUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXpftjmm8wcFlFhYbZ6xntfjYc4/V
        4vKuOWwWM87vY7JYe+Quu8XFU64Wh9+0s1r8u7aRxWLVrj+MDpwe72+0snvsnHWX3WPTqk42
        j74tqxg9Pm+SC2CN4rJJSc3JLEst0rdL4Mr4cGEOc8E0y4or9w6xNzBu0e1i5OSQEDCRaF3V
        x9bFyMUhJLCDUWLh9T/sEAlJiWkXjzJ3MXIA2cIShw8Xg4SFBN4yStzZKwJiCwvESSyfsZYJ
        pEREwEtiXgPYSGaBvYwS/39WQozsY5RoPLybGSTBJqAlsf/FDTYQm19AUeLqj8eMIDavgJ3E
        opnHwOIsAqoSG3efYgWxRQXCJHYuecwEUSMocXLmExYQm1PAWuLG7WXMEMvUJf7MuwRli0vc
        ejKfCcKWl9j+dg7zBEbhWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz
        0vWS83M3MYKjS0trB+OeVR/0DjEycTAeYpTgYFYS4WW+bBwvxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnPfrrIVxQgLpiSWp2ampBalFMFkmDk6pBqa923/+UtuyaW7IQSPrvt+X6vk3SjJd6FvP
        eOapzc7cn9MPmbutV+j3Dl1wY1eG4BuvKzvEdPcujhfYuzebyb8tddK/5L8zPGxTtohc8xUK
        2fHo87H4VDY/pvP7/t47ozn1uV4br/HN8FnXjmzUiDjapdC3OPRP3oultXIWul8t52wp/Pjm
        mubVXR7J8/dOWd976tijvlcJS5h3SD77miq8dyv7xcm8fLwqYhGTTe0yyuW4/7VeFlJTc3oe
        x365ettOcbmI8/fmz45mmPbBVX37jI1MDmYVDooWMT0vF7y562tzycvAbEbmevPdmgX/DscY
        z3r5YqM/j9HB3A/x1toNCUkat9e2uvaZ7ZfboqCjxFKckWioxVxUnAgArj15mB0DAAA=
X-CMS-MailID: 20200814003415epcas1p3fb798e831cfbab79c28e6dca8cdc8959
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200813095520eucas1p209432599420d62e0e54a5545334c329c
References: <CGME20200813095520eucas1p209432599420d62e0e54a5545334c329c@eucas1p2.samsung.com>
        <20200813095508.7563-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

On 8/13/20 6:55 PM, Sylwester Nawrocki wrote:
> In the .set_rate callback for some PLLs there is a loop polling state
> of the PLL lock bit and it may become an endless loop when something
> goes wrong with the PLL. For some PLLs there is already code for polling
> with a timeout but it uses the ktime API, which doesn't work in some
> conditions when the set_rate op is called, in particular during
> initialization of the clk provider before the clocksource initialization
> has completed. Hence the ktime API cannot be used to reliably detect
> the PLL locking timeout.
> 
> This patch adds a common helper function for busy waiting on the PLL lock
> bit with timeout detection.
> 
> Actual PLL lock time depends on the P divider value, the VCO frequency
> and a constant PLL type specific LOCK_FACTOR and can be calculated as
> 
>  lock_time = Pdiv * LOCK_FACTOR / VCO_freq
> 
> Common timeout value of 10 ms is used for all the PLLs with an assumption
> that maximum possible value of Pdiv is 64, maximum possible LOCK_FACTOR
> value is 3000 and minimum VCO frequency is 24 MHz.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v3:
>  - use busy-loop with udelay() instead of ktime API
> Changes for v2:
>  - use common readl_relaxed_poll_timeout_atomic() macro
> ---
>  drivers/clk/samsung/clk-pll.c | 94 ++++++++++++++++---------------------------
>  1 file changed, 34 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
> index ac70ad7..c83d261 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -15,7 +15,7 @@
>  #include "clk.h"
>  #include "clk-pll.h"
> 
> -#define PLL_TIMEOUT_MS		10
> +#define PLL_TIMEOUT_US		10000U
> 
>  struct samsung_clk_pll {
>  	struct clk_hw		hw;
> @@ -63,6 +63,25 @@ static long samsung_pll_round_rate(struct clk_hw *hw,
>  	return rate_table[i - 1].rate;
>  }
> 
> +static int samsung_pll_lock_wait(struct samsung_clk_pll *pll,
> +				 unsigned int reg_mask)
> +{
> +	int i;
> +
> +	/* Wait until the PLL is in steady locked state */
> +	for (i = 0; i < PLL_TIMEOUT_US / 2; i++) {
> +		if (readl_relaxed(pll->con_reg) & reg_mask)
> +			return 0;
> +
> +		udelay(2);
> +		cpu_relax();
> +	}
> +
> +	pr_err("Could not lock PLL %s\n", clk_hw_get_name(&pll->hw));
> +
> +	return -ETIMEDOUT;
> +}
> +
>  static int samsung_pll3xxx_enable(struct clk_hw *hw)
>  {
>  	struct samsung_clk_pll *pll = to_clk_pll(hw);
> @@ -241,12 +260,9 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
>  	writel_relaxed(tmp, pll->con_reg);
> 
>  	/* Wait until the PLL is locked if it is enabled. */
> -	if (tmp & BIT(pll->enable_offs)) {
> -		do {
> -			cpu_relax();
> -			tmp = readl_relaxed(pll->con_reg);
> -		} while (!(tmp & BIT(pll->lock_offs)));
> -	}
> +	if (tmp & BIT(pll->enable_offs))
> +		return samsung_pll_lock_wait(pll, BIT(pll->lock_offs));
> +
>  	return 0;
>  }
> 
> @@ -318,7 +334,7 @@ static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long drate,
>  					unsigned long parent_rate)
>  {
>  	struct samsung_clk_pll *pll = to_clk_pll(hw);
> -	u32 tmp, pll_con0, pll_con1;
> +	u32 pll_con0, pll_con1;
>  	const struct samsung_pll_rate_table *rate;
> 
>  	rate = samsung_get_pll_settings(pll, drate);
> @@ -356,13 +372,8 @@ static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long drate,
>  	pll_con1 |= rate->kdiv << PLL36XX_KDIV_SHIFT;
>  	writel_relaxed(pll_con1, pll->con_reg + 4);
> 
> -	/* wait_lock_time */
> -	if (pll_con0 & BIT(pll->enable_offs)) {
> -		do {
> -			cpu_relax();
> -			tmp = readl_relaxed(pll->con_reg);
> -		} while (!(tmp & BIT(pll->lock_offs)));
> -	}
> +	if (pll_con0 & BIT(pll->enable_offs))
> +		return samsung_pll_lock_wait(pll, BIT(pll->lock_offs));
> 
>  	return 0;
>  }
> @@ -437,7 +448,6 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
>  	struct samsung_clk_pll *pll = to_clk_pll(hw);
>  	const struct samsung_pll_rate_table *rate;
>  	u32 con0, con1;
> -	ktime_t start;
> 
>  	/* Get required rate settings from table */
>  	rate = samsung_get_pll_settings(pll, drate);
> @@ -489,20 +499,7 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
>  	writel_relaxed(con0, pll->con_reg);
> 
>  	/* Wait for locking. */
> -	start = ktime_get();
> -	while (!(readl_relaxed(pll->con_reg) & PLL45XX_LOCKED)) {
> -		ktime_t delta = ktime_sub(ktime_get(), start);
> -
> -		if (ktime_to_ms(delta) > PLL_TIMEOUT_MS) {
> -			pr_err("%s: could not lock PLL %s\n",
> -					__func__, clk_hw_get_name(hw));
> -			return -EFAULT;
> -		}
> -
> -		cpu_relax();
> -	}
> -
> -	return 0;
> +	return samsung_pll_lock_wait(pll, PLL45XX_LOCKED);
>  }
> 
>  static const struct clk_ops samsung_pll45xx_clk_ops = {
> @@ -588,7 +585,6 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
>  	struct samsung_clk_pll *pll = to_clk_pll(hw);
>  	const struct samsung_pll_rate_table *rate;
>  	u32 con0, con1, lock;
> -	ktime_t start;
> 
>  	/* Get required rate settings from table */
>  	rate = samsung_get_pll_settings(pll, drate);
> @@ -648,20 +644,7 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
>  	writel_relaxed(con1, pll->con_reg + 0x4);
> 
>  	/* Wait for locking. */
> -	start = ktime_get();
> -	while (!(readl_relaxed(pll->con_reg) & PLL46XX_LOCKED)) {
> -		ktime_t delta = ktime_sub(ktime_get(), start);
> -
> -		if (ktime_to_ms(delta) > PLL_TIMEOUT_MS) {
> -			pr_err("%s: could not lock PLL %s\n",
> -					__func__, clk_hw_get_name(hw));
> -			return -EFAULT;
> -		}
> -
> -		cpu_relax();
> -	}
> -
> -	return 0;
> +	return samsung_pll_lock_wait(pll, PLL46XX_LOCKED);
>  }
> 
>  static const struct clk_ops samsung_pll46xx_clk_ops = {
> @@ -1035,14 +1018,9 @@ static int samsung_pll2550xx_set_rate(struct clk_hw *hw, unsigned long drate,
>  			(rate->sdiv << PLL2550XX_S_SHIFT);
>  	writel_relaxed(tmp, pll->con_reg);
> 
> -	/* wait_lock_time */
> -	do {
> -		cpu_relax();
> -		tmp = readl_relaxed(pll->con_reg);
> -	} while (!(tmp & (PLL2550XX_LOCK_STAT_MASK
> -			<< PLL2550XX_LOCK_STAT_SHIFT)));
> -
> -	return 0;
> +	/* Wait for locking. */
> +	return samsung_pll_lock_wait(pll,
> +			PLL2550XX_LOCK_STAT_MASK << PLL2550XX_LOCK_STAT_SHIFT);
>  }
> 
>  static const struct clk_ops samsung_pll2550xx_clk_ops = {
> @@ -1132,13 +1110,9 @@ static int samsung_pll2650x_set_rate(struct clk_hw *hw, unsigned long drate,
>  	con1 |= ((rate->kdiv & PLL2650X_K_MASK) << PLL2650X_K_SHIFT);
>  	writel_relaxed(con1, pll->con_reg + 4);
> 
> -	do {
> -		cpu_relax();
> -		con0 = readl_relaxed(pll->con_reg);
> -	} while (!(con0 & (PLL2650X_LOCK_STAT_MASK
> -			<< PLL2650X_LOCK_STAT_SHIFT)));
> -
> -	return 0;
> +	/* Wait for locking. */
> +	return samsung_pll_lock_wait(pll,
> +			PLL2650X_LOCK_STAT_MASK << PLL2650X_LOCK_STAT_SHIFT);
>  }
> 
>  static const struct clk_ops samsung_pll2650x_clk_ops = {
> --
> 2.7.4
> 
> 
> 

Thanks.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
