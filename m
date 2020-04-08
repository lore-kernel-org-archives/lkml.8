Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CD3C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 08:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E194920771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 08:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586333383;
	bh=uUSrnD2b+t7jwXeUGhWXZyXgEQB1fI6tRrbRuRU/Ysc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mUqPvKGMgDekQbkOTDa0GkAJe3fcBkDB/Zu7DZan4wYUf5PwnFmswfEZPPryUoUnT
	 d0L+xRA4smeYPei45OxsSGIEfCWtzZHmVmeSQ2F6lz5P6VsvkaT+udHGwYmfCqrkL/
	 p7k/ZR0BIiSpUBG9dVa7JNNfbkwVk3AIQdBZhHSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgDHIJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 04:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgDHIJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 04:09:41 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5943720730;
        Wed,  8 Apr 2020 08:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586333380;
        bh=uUSrnD2b+t7jwXeUGhWXZyXgEQB1fI6tRrbRuRU/Ysc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BLVlrHLIZSkcaGQjiBiuUpXhrlJKTZwupV1uerxfAUMUlN2vAWjv/56enCLe+ETex
         JdBCcWZcuDlalrozNxTpe2cILn1dkMIjnfQN0B0QmohOB6k5f4UbpQt6ADh7mFo3GA
         JfOUJKDE/aCccRUUVKGVFmMIKIK8KBE/YC+MQfRk=
Date:   Wed, 8 Apr 2020 17:09:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        rostedt@goodmis.org, gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Message-Id: <20200408170934.7238715574818f31f03e687b@kernel.org>
In-Reply-To: <20200407111007.352324393@infradead.org>
References: <20200407110236.930134290@infradead.org>
        <20200407111007.352324393@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Apr 2020 13:02:39 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> +static bool insn_is_vmx(struct insn *insn)
> +{
> +	u8 modrm = insn->modrm.bytes[0];
> +	u8 modrm_mod = X86_MODRM_MOD(modrm);
> +	u8 modrm_reg = X86_MODRM_REG(modrm);
> +
> +	u8 prefix = insn->prefixes.bytes[0];

This should be the last prefix,

	u8 prefix = insn->prefixes.bytes[3];

(The last prefix always copied on the bytes[3])

> +
> +	if (insn->opcode.bytes[0] != 0x0f)
> +		return false;
> +
> +	switch (insn->opcode.bytes[1]) {
> +	case 0x01:
> +		switch (insn->opcode.bytes[2]) {

Sorry, VMCALL etc. is in Grp7 (0f 01), the 3rd code is embedded
in modrm instead of opcode. Thus it should be,

		switch (insn->modrm.value) {

> +		case 0xc1: /* VMCALL */
> +		case 0xc2: /* VMLAUNCH */
> +		case 0xc3: /* VMRESUME */
> +		case 0xc4: /* VMXOFF */

		case 0xd4:	/* VMFUNC */

> +			return true;
> +
> +		default:
> +			break;
> +		}
> +		break;
> +
> +	case 0x78: /* VMREAD */
> +	case 0x79: /* VMWRITE */

		return !insn_is_evex(insn);

With EVEX prefix, these becomes vcvt* instructions.

> +	case 0xc7:
> +		/* VMPTRLD, VMPTRST, VMCLEAR, VMXON */
> +		if (modrm_mod == 0x03)
> +			break;
> +
> +		if ((modrm_reg == 6 && (!prefix || prefix == 0x66 || prefix == 0xf3)) ||
> +		    (modrm_reg == 7 && (!prefix || prefix == 0xf3)))
> +			return true;
> +
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}


Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
