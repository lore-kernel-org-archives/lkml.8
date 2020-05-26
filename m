Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A7DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F1E20870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UJFw6H33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgEZPjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgEZPjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:39:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05382C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=HZtzUQOHJJbxRLXbEWcI7DHiTHaV4Bq8j2DkVGOmPWc=; b=UJFw6H33VaKEfLVoQbjRTerwwF
        SQ5A7dNQQ8ZXfS0OV4ynBAjW4NmT6aK6I8OR9mqJi/Xm7VbS5Lo7WuK+4WRQ5AE5k843osfFaeRtF
        D8/rzIDcMYOZzeyS8H34z48l8womx6UniE1b83GFrcPSqszsqtE8bzdAupo2buksqMXE8rhmoskaG
        PduvZUb3OWUZrw4GMd0w/V+Ww1rHwD35yXjOGP+U6AQU5biYBonN1Pri65qo0Nq1UW2QS4+tn2Xsn
        TdgifXVA//M05RjWaEOfWwFLxBjJH93aoEdvt7I45MNLo3gZEgvtflbt7L+I519qq1MRXwR5FtIlr
        PIhGf9nA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdbfL-00057F-Rn; Tue, 26 May 2020 15:38:55 +0000
Subject: Re: [PATCH 1/1] phy: intel: Fix compilation error on FIELD_PREP usage
To:     Dilip Kota <eswara.kota@linux.intel.com>,
        linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <d8a71fafa408f273fe63b64481448c29c450fa83.1590477581.git.eswara.kota@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8e0af101-06b7-b088-02ce-ef52ae7f02d2@infradead.org>
Date:   Tue, 26 May 2020 08:38:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d8a71fafa408f273fe63b64481448c29c450fa83.1590477581.git.eswara.kota@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 1:43 AM, Dilip Kota wrote:
> FIELD_PREP expects mask variable datatype as unsigned long and constant.
> Make the mask argument in combo_phy_w32_off_mask () as unsigned long const
> datatype.
> 
> Error reported as:
> In file included from include/linux/build_bug.h:5,
> from include/linux/bitfield.h:10,
> from drivers/phy/intel/phy-intel-combo.c:8:
> drivers/phy/intel/phy-intel-combo.c: In function 'combo_phy_w32_off_mask':
> include/linux/bitfield.h:52:28: warning: comparison is always false due to limited range of data type [-Wtype-limits]
> 
> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_37' declared with attribute error: FIELD_PREP: mask is not constant
> 94 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");          |   ^~~~~~~~~~~~~~~~
> drivers/phy/intel/phy-intel-combo.c:137:13: note: in expansion of macro 'FIELD_PREP'
> 137 |  reg_val |= FIELD_PREP(mask, val);
> |             ^~~~~~~~~~
> 
> Fixes: ac0a95a3ea78 ("phy: intel: Add driver support for ComboPhy")
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> Reported-by: kbuild test robot <lkp@intel.com>

also
Reported-by: Randy Dunlap <rdunlap@infradead.org>

here:
https://lore.kernel.org/linux-fsdevel/9960b5aa-4a8e-15a4-6e0b-63561f760d3a@infradead.org/

but I still see build errors after applying this patch.

  CC      drivers/phy/intel/phy-intel-combo.o
In file included from ../include/linux/build_bug.h:5:0,
                 from ../include/linux/bitfield.h:10,
                 from ../drivers/phy/intel/phy-intel-combo.c:8:
../drivers/phy/intel/phy-intel-combo.c: In function ‘combo_phy_w32_off_mask’:
../include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_133’ declared with attribute error: FIELD_PREP: mask is not constant
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
../include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
    prefix ## suffix();    \
    ^~~~~~
../include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
../include/linux/bitfield.h:46:3: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),  \
   ^~~~~~~~~~~~~~~~
../include/linux/bitfield.h:94:3: note: in expansion of macro ‘__BF_FIELD_CHECK’
   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
   ^~~~~~~~~~~~~~~~
../drivers/phy/intel/phy-intel-combo.c:137:13: note: in expansion of macro ‘FIELD_PREP’
  reg_val |= FIELD_PREP(mask, val);
             ^~~~~~~~~~
../include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_137’ declared with attribute error: BUILD_BUG_ON failed: (((mask) + (1ULL << (__builtin_ffsll(mask) - 1))) & (((mask) + (1ULL << (__builtin_ffsll(mask) - 1))) - 1)) != 0
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
../include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
    prefix ## suffix();    \
    ^~~~~~
../include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^~~~~~~~~~~~~~~~
../include/linux/build_bug.h:21:2: note: in expansion of macro ‘BUILD_BUG_ON’
  BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
  ^~~~~~~~~~~~
../include/linux/bitfield.h:54:3: note: in expansion of macro ‘__BUILD_BUG_ON_NOT_POWER_OF_2’
   __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +   \
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../include/linux/bitfield.h:94:3: note: in expansion of macro ‘__BF_FIELD_CHECK’
   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
   ^~~~~~~~~~~~~~~~
../drivers/phy/intel/phy-intel-combo.c:137:13: note: in expansion of macro ‘FIELD_PREP’
  reg_val |= FIELD_PREP(mask, val);
             ^~~~~~~~~~


> ---
>  drivers/phy/intel/phy-intel-combo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-combo.c
> index c2a35be4cdfb..05b7d724ceb0 100644
> --- a/drivers/phy/intel/phy-intel-combo.c
> +++ b/drivers/phy/intel/phy-intel-combo.c
> @@ -128,7 +128,7 @@ static int intel_cbphy_pcie_refclk_cfg(struct intel_cbphy_iphy *iphy, bool set)
>  }
>  
>  static inline void combo_phy_w32_off_mask(void __iomem *base, unsigned int reg,
> -					  u32 mask, u32 val)
> +					  unsigned long const mask, u32 val)
>  {
>  	u32 reg_val;
>  
> 


-- 
~Randy
