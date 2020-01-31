Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9C3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A494420CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgAaSzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:55:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:32912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgAaSzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:55:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 06371AC5F;
        Fri, 31 Jan 2020 18:55:45 +0000 (UTC)
Date:   Fri, 31 Jan 2020 19:55:31 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Steven Clarkson <sc@lambdal.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Handle malformed SRAT tables during early ACPI
 parsing
Message-ID: <20200131185531.GC14851@zn.tnic>
References: <CAHKq8taGzj0u1E_i=poHUam60Bko5BpiJ9jn0fAupFUYexvdUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHKq8taGzj0u1E_i=poHUam60Bko5BpiJ9jn0fAupFUYexvdUQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 04:48:16PM -0800, Steven Clarkson wrote:
> Break an infinite loop when early parsing SRAT caused by a subtable with
> zero length. Known to affect the ASUS WS X299 SAGE motherboard with
> firmware version 1201, which has a large block of zeros in its SRAT table.
> The kernel could boot successfully on this board/firmware prior to the
> introduction of early parsing this table.
> 
> Fixes: 02a3e3cdb7f1 ("x86/boot: Parse SRAT table and count immovable
> memory regions")
> Signed-off-by: Steven Clarkson <sc@lambdal.com>
> ---
>  arch/x86/boot/compressed/acpi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 25019d42ae93..1a4479c5edfc 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -394,6 +394,12 @@ int count_immovable_mem_regions(void)
> 
>         while (table + sizeof(struct acpi_subtable_header) < table_end) {
>                 sub_table = (struct acpi_subtable_header *)table;
> +
> +               if (!sub_table->length) {
> +                       debug_putstr("Invalid zero length SRAT subtable.\n");
> +                       break;
> +               }
> +
>                 if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
>                         struct acpi_srat_mem_affinity *ma;
> 
> -- 

Only in case you want to send patches in the future, see below.
scripts/checkpatch.pl can do that checking for you before you send. I'll
fix it up now.

ERROR: code indent should use tabs where possible
#37: FILE: arch/x86/boot/compressed/acpi.c:398:
+               if (!sub_table->length) {$

WARNING: please, no spaces at the start of a line
#37: FILE: arch/x86/boot/compressed/acpi.c:398:
+               if (!sub_table->length) {$

WARNING: suspect code indent for conditional statements (15, 23)
#37: FILE: arch/x86/boot/compressed/acpi.c:398:
+               if (!sub_table->length) {
+                       debug_putstr("Invalid zero length SRAT subtable.\n");

ERROR: code indent should use tabs where possible
#38: FILE: arch/x86/boot/compressed/acpi.c:399:
+                       debug_putstr("Invalid zero length SRAT subtable.\n");$

WARNING: please, no spaces at the start of a line
#38: FILE: arch/x86/boot/compressed/acpi.c:399:
+                       debug_putstr("Invalid zero length SRAT subtable.\n");$

ERROR: code indent should use tabs where possible
#39: FILE: arch/x86/boot/compressed/acpi.c:400:
+                       break;$

WARNING: please, no spaces at the start of a line
#39: FILE: arch/x86/boot/compressed/acpi.c:400:
+                       break;$

ERROR: code indent should use tabs where possible
#40: FILE: arch/x86/boot/compressed/acpi.c:401:
+               }$

WARNING: please, no spaces at the start of a line
#40: FILE: arch/x86/boot/compressed/acpi.c:401:
+               }$

total: 4 errors, 5 warnings, 12 lines checked


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
