Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD18C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C82320679
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i3xEcQ3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgFPJNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgFPJNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:13:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB040C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 02:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BMgjJ+FUF3BJuXtsz4OtJLb5FBjhC81wWLgGsI5KxOU=; b=i3xEcQ3V+wliLmPApOwIwoyGSr
        ZINPVulDpPEjeMl6ksFfrI6mzduJ7A9IcTg1vvXWGMLyJ7AkyjdZ4Pm/1pZP6am/vAHjXEJ5Kt8Mq
        XWGuPwHp/oxVhx14rUHgLp+fYUs6jsaDel34xiWxYarIjnNRwDohOO2kaDZ8wsS8mmV3hr5UbHfl9
        +8GEGU7wVOzf1iyiYS+8vm7nogeCVmRCihKR77zEnurG/eco15ia07vPBKnF8zeAAxD+pre6+U7Pd
        MwNyGR/JpKPKec/9ZlfpbzKpqBtd+3Wo6GGONDkmpN2FBI1zkcRi+57OKqgOWpNDUJkXOrOKAwBsY
        Phu07o8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jl7eK-0001cI-19; Tue, 16 Jun 2020 09:12:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0EB32301A32;
        Tue, 16 Jun 2020 11:12:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCBF5201CB859; Tue, 16 Jun 2020 11:12:53 +0200 (CEST)
Date:   Tue, 16 Jun 2020 11:12:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, dvyukov@google.com,
        elver@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        mhelsley@vmware.com, rostedt@goodmis.org, jthierry@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 2/3] objtool: Provide elf_write_{insn,reloc}()
Message-ID: <20200616091253.GN2531@hirez.programming.kicks-ass.net>
References: <20200612143034.933422660@infradead.org>
 <20200612143554.012293047@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612143554.012293047@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 04:30:36PM +0200, Peter Zijlstra wrote:
> +int elf_write_insn(struct elf *elf, struct section *sec,
> +		   unsigned long offset, unsigned int len,
> +		   const char *insn)
> +{
> +	Elf_Data *data = sec->data;
> +
> +	if (data->d_type != ELF_T_BYTE || data->d_off) {
> +		WARN("write to unexpected data for section: %s", sec->name);
> +		return -1;
> +	}
> +
> +	memcpy(data->d_buf + offset, insn, len);
> +	elf_flagdata(data, ELF_C_SET, ELF_F_DIRTY);
> +
> +	sec->changed = true;
> +	elf->changed = true;
> +
> +	return 0;
> +}
> +
> +int elf_write_reloc(struct elf *elf, struct reloc *reloc)
> +{
> +	struct section *sec = reloc->sec;
> +
> +	if (sec->sh.sh_type == SHT_REL) {
> +		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
> +		reloc->rel.r_offset = reloc->offset;
> +
> +		if (!gelf_update_rel(sec->data, reloc->idx, &reloc->rel)) {
> +			WARN_ELF("gelf_update_rel");
> +			return -1;
> +		}
> +	} else {
> +		reloc->rela.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
> +		reloc->rela.r_addend = reloc->addend;
> +		reloc->rela.r_offset = reloc->offset;
> +
> +		if (!gelf_update_rela(sec->data, reloc->idx, &reloc->rela)) {
> +			WARN_ELF("gelf_update_rela");
> +			return -1;
> +		}
> +	}
> +
> +	sec->changed = true;
> +	elf->changed = true;
> +
> +	return 0;
> +}

Doing the change Matt asked for #1, I realized that sec->changed is only
required if we need to rewrite the section header, neither of these two
changes requires that, they already mark the elf data dirty so
elf_update() DTRT.
