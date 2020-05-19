Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28424C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18D4206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589859280;
	bh=Ew9WSbxHlG1e79O/eF3sP7/t7fsVShQrjZ3HmpHj6ok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Onc9nkjQdCGopWijWZ+QlfDrIcNK2hU1gZBfyNKMouZ+yvS6BkdC7YpX2m9fDRdcI
	 E7KgTS90WIM7kTyZ3JphzO1DrZuQeJkp8MvFyvNipuJYx9eXlf9DqInrbp396Vk06G
	 DyPSwK/zWpxvNpn+aEHQ/ummgImomYFEWLF9vs5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgESDej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 23:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgESDej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 23:34:39 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF35A204EF;
        Tue, 19 May 2020 03:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589859278;
        bh=Ew9WSbxHlG1e79O/eF3sP7/t7fsVShQrjZ3HmpHj6ok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SsCtl4mGJEwEUe96KkQtYVbR6BtoJw9xmwETC1EYCBWMDzbB/++8GmNwn3j1cvk5t
         X8luuK69SAjTDOCt+gPTTsdC1qKWhGgn2bVNbSaSNhTFX14ge+8stbbJPRZDZFxtFH
         lX+rd+rTSO4S2FGggM2Us207qBwpDkR0QigcD4+U=
Date:   Mon, 18 May 2020 20:34:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     maobibo <maobibo@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paulburton@kernel.org>,
        Dmitry Korotin <dkorotin@wavecomp.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Stafford Horne <shorne@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "Maciej W. Rozycki" <macro@wdc.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 3/3] mm/memory.c: Add memory read privilege before
 filling PTE entry
Message-Id: <20200518203437.8b2df678261d756a8c477f40@linux-foundation.org>
In-Reply-To: <d1646320-51ec-4b5f-bcad-41eba85b78cf@loongson.cn>
References: <1589778529-25627-1-git-send-email-maobibo@loongson.cn>
        <1589778529-25627-3-git-send-email-maobibo@loongson.cn>
        <20200518135747.d8837ba6742b2d193e14fbb0@linux-foundation.org>
        <d1646320-51ec-4b5f-bcad-41eba85b78cf@loongson.cn>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 11:22:49 +0800 maobibo <maobibo@loongson.cn> wrote:

> how about adding pte_sw_mkyoung alike function which is a noop on all but mips?
> this function is used to set PAGE_ACCESS bit and PAGE_VALID bit on mips platform.

Sounds good.  Please ensure that the interface (roles and
responsibilities, etc) is well documented in code comments.

