Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700A4C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6A920735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgCQMWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:22:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:48968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgCQMWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:22:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 34410B1B3;
        Tue, 17 Mar 2020 12:22:24 +0000 (UTC)
Date:   Tue, 17 Mar 2020 13:22:23 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 08/16] Optimize find_section_by_name()
In-Reply-To: <20200312135041.875820323@infradead.org>
Message-ID: <alpine.LSU.2.21.2003171321170.2339@pobox.suse.cz>
References: <20200312134107.700205216@infradead.org> <20200312135041.875820323@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -193,6 +198,7 @@ static int read_sections(struct elf *elf
>  		sec->len = sec->sh.sh_size;
>  
>  		hash_add(elf->section_hash, &sec->hash, sec->idx);
> +		hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
>  	}

Don't you need to the same in elf_create_section()?

Miroslav
