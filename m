Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CF2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1433206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgESSzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:55:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:23445 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgESSzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:55:04 -0400
IronPort-SDR: OPaOBGmdv8zSeO+fsRBiYDZicNS8axoMljuWVxMWqELm3dJYl16HCfXRdyoO6+QpFbZf6aeSh0
 QDQYQxJJEXcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 11:55:04 -0700
IronPort-SDR: ujcNGjyE6y8rQbxambZYi8cvmIBePLItx+ZNsWpo9RucMtGsWI2ImjEquZ6dNqIHtr0n1vejke
 VZ+92+1RvTJQ==
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="439725808"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.255.229.46]) ([10.255.229.46])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 11:55:03 -0700
Subject: Re: [PATCH v3 09/10] x86/resctrl: Add arch_has_{sparse,empty}_bitmaps
 to explain CAT differences
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>
References: <20200518131924.7741-1-james.morse@arm.com>
 <20200518131924.7741-10-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <2f8d9fb3-da66-21ff-147b-d1f7deaaed73@intel.com>
Date:   Tue, 19 May 2020 11:55:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518131924.7741-10-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thank you very much for adding the handling of empty bitmaps. This looks
good to me, just one comment ...

On 5/18/2020 6:19 AM, James Morse wrote:
> -bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
> +static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  {
>  	unsigned long first_bit, zero_bit, val;
>  	unsigned int cbm_len = r->cache.cbm_len;
> @@ -93,7 +95,8 @@ bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
>  		return false;
>  	}
>  
> -	if (val == 0 || val > r->default_ctrl) {
> +	if ((!r->cache.arch_has_empty_bitmaps && val == 0) ||
> +	    (val > r->default_ctrl)) {
>  		rdt_last_cmd_puts("Mask out of range\n");
>  		return false;

There is unnecessary parentheses around 'val > r->default_ctrl'

Reinette
