Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F26C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4BB206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339075;
	bh=HXBYUJjyLsFEYeVDNirUeUnuXUm5SXGnUmEnR2UscT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lhrHyxSygDokRTcjX6JuVqs5wA0NPiEXbJtbqgWualbFingh0idC8w/+oZ763+rNg
	 PVzdnbvyoBnbq2kUyukUS65pX5VVHC6OEDXx1fZrM5fINEF3BpuJlfPk8K6PiGGy3H
	 ThUy43PtiwVC/mDuoJ6VctY0OzWiDkvxPhcAlduk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgBJMny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:43:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729643AbgBJMkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:11 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 132E324649;
        Mon, 10 Feb 2020 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338411;
        bh=HXBYUJjyLsFEYeVDNirUeUnuXUm5SXGnUmEnR2UscT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0OXOuGpC02vc+iXQJek6EBpMRgxRTdFFFNpIWEK7c4mH1cCPZl5yII6EaJFWb27J
         qZL9pY31rcOWhylO5nvl0CsNpuH8YE61Nn2xynIFAjE6AJ3EzwP75XqichneRzcQDX
         sUOUbBZS+0OLPQ6cnyYayiudhdMXJi/3WwO/HDUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Lobakin <alobakin@dlink.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH 5.5 078/367] MIPS: fix indentation of the RELOCS message
Date:   Mon, 10 Feb 2020 04:29:51 -0800
Message-Id: <20200210122431.448343266@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alobakin@dlink.ru>

commit a53998802e178451701d59d38e36f551422977ba upstream.

quiet_cmd_relocs lacks a whitespace which results in:

  LD      vmlinux
  SORTEX  vmlinux
  SYSMAP  System.map
  RELOCS vmlinux
  Building modules, stage 2.
  MODPOST 64 modules

After this patch:

  LD      vmlinux
  SORTEX  vmlinux
  SYSMAP  System.map
  RELOCS  vmlinux
  Building modules, stage 2.
  MODPOST 64 modules

Typo is present in kernel tree since the introduction of relocatable
kernel support in commit e818fac595ab ("MIPS: Generate relocation table
when CONFIG_RELOCATABLE"), but the relocation scripts were moved to
Makefile.postlink later with commit 44079d3509ae ("MIPS: Use
Makefile.postlink to insert relocations into vmlinux").

Fixes: 44079d3509ae ("MIPS: Use Makefile.postlink to insert relocations into vmlinux")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
[paulburton@kernel.org: Fixup commit references in commit message.]
Signed-off-by: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/Makefile.postlink |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/Makefile.postlink
+++ b/arch/mips/Makefile.postlink
@@ -17,7 +17,7 @@ quiet_cmd_ls3_llsc = LLSCCHK $@
       cmd_ls3_llsc = $(CMD_LS3_LLSC) $@
 
 CMD_RELOCS = arch/mips/boot/tools/relocs
-quiet_cmd_relocs = RELOCS $@
+quiet_cmd_relocs = RELOCS  $@
       cmd_relocs = $(CMD_RELOCS) $@
 
 # `@true` prevents complaint when there is nothing to be done


