Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40BBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0CC32082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ct9KFZUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390580AbgFXLK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:10:56 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:31553 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgFXLKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:10:55 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200624111052epoutp02b4dac943201350653bf768cb0d05fa9c~bdmEoUKEj1942119421epoutp02Y
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:10:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200624111052epoutp02b4dac943201350653bf768cb0d05fa9c~bdmEoUKEj1942119421epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592997052;
        bh=GXE5Ev/ANiwwas6mD2jNrpygy/hRdwB5x3t6IyL9T0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ct9KFZUtgMFof9JSmotNW3onJZRLLviyXhU9SwMkdRU8EOOTYpNO31wqCxDkgOz7W
         7RGxeWeuFRt/MWAHiTI1cqWFJ+N15DyZpN32vJ+6ZOFBJV6a8pBJpEbMoiIfNdcTWZ
         6fg5WqfgBXZUl+ylndQowQJkL79ZEs/VAEYXOMMo=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200624111051epcas5p3fd3a4fedcf34699356a4c3a35e76580e~bdmDzGG481682616826epcas5p3L;
        Wed, 24 Jun 2020 11:10:51 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.E1.09703.BB433FE5; Wed, 24 Jun 2020 20:10:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200624104045epcas5p43d47f01a4536d794c1d1e7c2ca78cb6e~bdLxUGWSe0398903989epcas5p4q;
        Wed, 24 Jun 2020 10:40:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200624104045epsmtrp1e2acc66794694d800334b8e74baa5255~bdLxTfVHn2582425824epsmtrp1G;
        Wed, 24 Jun 2020 10:40:45 +0000 (GMT)
X-AuditID: b6c32a4a-4b5ff700000025e7-3f-5ef334bba565
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.08.08382.DAD23FE5; Wed, 24 Jun 2020 19:40:45 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200624104044epsmtip14286e1704a27383342feef501a81df54~bdLwZqGt91497614976epsmtip1M;
        Wed, 24 Jun 2020 10:40:44 +0000 (GMT)
From:   Vishal Goel <vishal.goel@samsung.com>
To:     rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Cc:     Vishal Goel <vishal.goel@samsung.com>,
        Amit Sahrawat <a.sahrawat@samsung.com>
Subject: [PATCH 1/1] Module:- Do not store unnecessary symbols for kernel
 modules
Date:   Wed, 24 Jun 2020 15:48:18 +0530
Message-Id: <1592993898-14307-1-git-send-email-vishal.goel@samsung.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <Do not store unnecessary symbols for kernel modules>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCmpu5uk89xBq97zS0u7k61uLxrDpvF
        zWkXWCzW3T7N6MDisWLDCWaPvi2rGD0+b5ILYI7isklJzcksSy3St0vgyni+7xd7wRuJim2t
        pxkbGD8LdzFyckgImEg8O3uVpYuRi0NIYDejxLUJh6CcT4wSy443MkE43xglrjZMYoFpWf/m
        GzNEYi+jxOSHh1khnC+MEu1n+9lAqtgEtCV6590FaufgEBEwl5g9rRQkzCwQLLHxwxWwQcJA
        9pp/H8DKWQRUJfr7f4PZvALuEl3frjJDLJOTOHlsMiuIzSngJHFkw12wiyQElrFLPLx/gA2i
        yEWibdZPqAZhiVfHt7BD2FISL/vb2CEa2hkljs7aCOVMYZT4t+8GVJW9xOvmBrBLmQU0Jdbv
        0ocIy0pMPbWOCeJqPone30+YIOK8EjvmwdiqElMndUONkZY4fOMMNIg8JA6d/gQNu6mMEqt+
        LGKdwCg3C2HFAkbGVYySqQXFuempxaYFRnmp5XrFibnFpXnpesn5uZsYwTGu5bWD8eGDD3qH
        GJk4GA8xSnAwK4nwhrh9ihPiTUmsrEotyo8vKs1JLT7EKM3BoiTOq/TjTJyQQHpiSWp2ampB
        ahFMlomDU6qBqdh31vUqpRnh9/UWXWtcoCOqPHX5zgjPidHCB9K0hA8aOTO8Mvzpei5YLzrp
        oM/GO7v4nytOrCl33HVzAaNV8bxLlWYLExoytyS57FSyTe//KW/glpTDz/jrE09jaZ6a5oZ2
        kV0iDenzl/TudJ6mUKCd/6xt9fuuvo+Xn8codRtdLLx/XFZkzZHrZ7uS5qb6/+N7+4rTUsHl
        ZH+aCb/CTtczYU8OaIrf9p27dpXX0yOmgtOAAXL9Wt7Sis8KkWZ/4/4URnqrOL3/nlHHFHdD
        Pmp/zryb7tvkt/kuF70m3B2/Z0W2q09R3ZPKHTFRawuvLMxf8zb4v7c2y6Ufxfoh0jYWzick
        5n1qqLDmSFNiKc5INNRiLipOBACZHLIHYAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJMWRmVeSWpSXmKPExsWy7bCSnO5a3c9xBq/ni1pc3J1qcXnXHDaL
        m9MusFisu32a0YHFY8WGE8wefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlfF83y/2gjcSFdta
        TzM2MH4W7mLk5JAQMJFY/+YbcxcjF4eQwG5GiYPb9rNAJKQllnS+YYewhSVW/nvODlH0iVGi
        //YeRpAEm4C2RO+8u0wgtoiApcSkk7OYQWxmgWCJ0z07wQYJCwRKzJ92nBXEZhFQlejv/80G
        YvMKuEt0fbvKDLFATuLksclgNZwCThJHNkDMFBJwlHhydDXLBEa+BYwMqxglUwuKc9Nziw0L
        DPNSy/WKE3OLS/PS9ZLzczcxgkNIS3MH4/ZVH/QOMTJxMB5ilOBgVhLhDXH7FCfEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmc90bhwjghgfTEktTs1NSC1CKYLBMHp1QDk6+vtfvmhpubNCa5ty73
        V5cPtaoMbKpZJnibZUthlNYyk5yI3SYNHA33AoImp29YvcwubaXxlw8XE1fcLtqgMmUuh1yQ
        +8rYWyv9v9wP2rG6z1fu++s1tmbhrr5+bUv3B5QmnfJuWv3jRXjCpaWPPHaIlr79XWLFcOKk
        9OxLrUsbowU1zy5k/vOHJU7DdmvoAz6T39vVYvzDDu8wX1CwVEzEQrLATeWfYaD06U9ruZ8s
        2LmT6+7s2OVdp7jNu5l2HLtcyMT6s9BqvXOMiYGDmcZXSZPDebe1boR+Kj0j8GVJ+f9ZZ3/N
        11z9a+/1E5qv7ux89myrWPuEKUu5FbVmfnr/53rXo0+pr8N9n8l+PqbEUpyRaKjFXFScCADE
        nGJDkAIAAA==
X-CMS-MailID: 20200624104045epcas5p43d47f01a4536d794c1d1e7c2ca78cb6e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200624104045epcas5p43d47f01a4536d794c1d1e7c2ca78cb6e
References: <Do not store unnecessary symbols for kernel modules>
        <CGME20200624104045epcas5p43d47f01a4536d794c1d1e7c2ca78cb6e@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While loading modules, ignores the mapping symbols found in ARM
ELF files: $a, $t and $d.
Also ignores symbols starting with .L found in rodata.str sections
It will help in saving memory allocated for modules using
vmalloc.

It can save around 500KB - 1000KB depending on the number of
modules and number of symbols present in them

Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>
---
 kernel/module.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 646f1e2..d5b7b0a 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2550,6 +2550,20 @@ static void free_modinfo(struct module *mod)
 
 #ifdef CONFIG_KALLSYMS
 
+/*
+ * This ignores the intensely annoying "mapping symbols" found
+ * in ARM ELF files: $a, $t and $d.
+ * It also ignores symbols starting with .L found in rodata.str sections
+ */
+static inline int is_arm_mapping_symbol(const char *str)
+{
+	if (str[0] == '.' && str[1] == 'L')
+		return true;
+	return str[0] == '$' && strchr("axtd", str[1])
+		&& (str[2] == '\0' || str[2] == '.');
+}
+
+
 /* Lookup exported symbol in given range of kernel_symbols */
 static const struct kernel_symbol *lookup_exported_symbol(const char *name,
 							  const struct kernel_symbol *start,
@@ -2664,8 +2678,9 @@ static void layout_symtab(struct module *mod, struct load_info *info)
 	/* Compute total space required for the core symbols' strtab. */
 	for (ndst = i = 0; i < nsrc; i++) {
 		if (i == 0 || is_livepatch_module(mod) ||
-		    is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
-				   info->index.pcpu)) {
+		    (is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
+				   info->index.pcpu) &&
+		     !is_arm_mapping_symbol(&info->strtab[src[i].st_name]))) {
 			strtab_size += strlen(&info->strtab[src[i].st_name])+1;
 			ndst++;
 		}
@@ -2728,8 +2743,9 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 	for (ndst = i = 0; i < mod->kallsyms->num_symtab; i++) {
 		mod->kallsyms->typetab[i] = elf_type(src + i, info);
 		if (i == 0 || is_livepatch_module(mod) ||
-		    is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
-				   info->index.pcpu)) {
+		    (is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
+				   info->index.pcpu) &&
+		     !is_arm_mapping_symbol(&info->strtab[src[i].st_name]))) {
 			mod->core_kallsyms.typetab[ndst] =
 			    mod->kallsyms->typetab[i];
 			dst[ndst] = src[i];
@@ -3986,17 +4002,6 @@ static inline int within(unsigned long addr, void *start, unsigned long size)
 }
 
 #ifdef CONFIG_KALLSYMS
-/*
- * This ignores the intensely annoying "mapping symbols" found
- * in ARM ELF files: $a, $t and $d.
- */
-static inline int is_arm_mapping_symbol(const char *str)
-{
-	if (str[0] == '.' && str[1] == 'L')
-		return true;
-	return str[0] == '$' && strchr("axtd", str[1])
-	       && (str[2] == '\0' || str[2] == '.');
-}
 
 static const char *kallsyms_symbol_name(struct mod_kallsyms *kallsyms, unsigned int symnum)
 {
-- 
1.9.1

