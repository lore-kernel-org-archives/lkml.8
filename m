Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92887C18E7A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A47222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WmyJ2sFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgCKDpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 23:45:01 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:51201 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgCKDo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:44:59 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200311034457epoutp02a4555a1af50e71deb0075d99ad7071be~7IxwQ-yEy2588025880epoutp02c
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 03:44:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200311034457epoutp02a4555a1af50e71deb0075d99ad7071be~7IxwQ-yEy2588025880epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583898297;
        bh=5O3DmxQG7sUQ77ojFXxku3rR8wOYI+x01rUSJILEbhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmyJ2sFP6IOEwCK1B8lQUXoK7GQmrNrozV2xHo8SM25d+qpbiflc2Wi3gMgb8msnH
         wDqqFTBLBU26Oq2zmrAu5CFzeRdd0nQ8HdH6Lmp222j/IFga4PbikMjOdiQNtPhuJx
         HZRj/EAeT8JGjjeai7dIN8BDW8/TdJg1Bz/7+Fdw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200311034456epcas1p18e1ae32617ab3a5cf2224860af11bd0a~7Ixv2BQjT2430724307epcas1p1d;
        Wed, 11 Mar 2020 03:44:56 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48cdBZ4vpczMqYkZ; Wed, 11 Mar
        2020 03:44:54 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.D7.51241.6BE586E5; Wed, 11 Mar 2020 12:44:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200311034454epcas1p184680d40f89d37eec7f934074c4a9fcf~7IxtYjwaN2904129041epcas1p1m;
        Wed, 11 Mar 2020 03:44:54 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200311034454epsmtrp12e13bf7399fb43470e88d9be6283a377~7IxtXmZZc3056330563epsmtrp1t;
        Wed, 11 Mar 2020 03:44:54 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-16-5e685eb65692
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.12.06569.6BE586E5; Wed, 11 Mar 2020 12:44:54 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200311034454epsmtip141d22e83ba5049ba4a80164f7943e6df~7IxtN312B1922919229epsmtip1i;
        Wed, 11 Mar 2020 03:44:54 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RFC PATCH 1/3] proc/meminfo: introduce extra meminfo
Date:   Wed, 11 Mar 2020 12:44:39 +0900
Message-Id: <20200311034441.23243-2-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200311034441.23243-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3a2szN1cVi3j5nLjhRYqFtzdjQnRhanNLALRBKug542aTd2
        Ni8RpvNeLnWElmkYWdGozCmSsvrDoiRCootFaKSYlV0kzQua2raj1H/P+76/h+/h/V4MkThR
        KZZltDIWI60n0AB+x6PwyIiOdF26fNS1mawr3Ec2tNxGyXNtlwDpGBvlkbc8MzzyVVcDSn64
        vSggb0yOCcl7xfVCcqjaySOfDUwIEwOpzvoBIeV2VaCUe9wppPr7PCjVc3GOT409fINS59td
        gOocbxNQE25ZqihNH69j6EzGEsoYM0yZWUatmkg+pNmlUcXIFRGKWHI7EWqkDYyaSEpJjdiT
        pfemJUKzab3N20qlWZaISoi3mGxWJlRnYq1qgjFn6s0KuTmSpQ2szaiNzDAZ4hRy+TaVlzyu
        1y0OORBzXVjuYN8sWgDOhZwFIgzi0XB4ugI9CwIwCX4fwOt1bYArxgHsfVwCfJQEnwKwaHr/
        sqP1eQOfgx4A2O4aFnDFNICeP7WIj0LxrXCsyekfrMbvADhvb+b7Bghugz++9/ihVXgCbLa/
        RH2aj2+Cxb0er8YwMa6GQx/zfRLiG+DVRT8t8tIT/e/96SD+FoU1g/0IlygJdrkvoJxeBUef
        tgs5LYVfq0qFnKEIwB+X2pbcxQAOuB2Ao5TQUfkC8b2G4OGwpSuKa2+EnXONgMu8Ev6crBRw
        gcSwvFTCIZth8cikgNPr4fzCyJKmYJnn1tIaawCs+vwAqQay+n8vNAHgAmsZM2vQMqzCrPr/
        y9zAf49bYu+DJ70p3QDHABEk/pKvTZcI6Gw2z9ANIIYQq8WaDd6WOJPOO8VYTBqLTc+w3UDl
        3WQNIl2TYfJet9GqUai2KZVKMjpme4xKSawTDx4NT5fgWtrKnGQYM2NZ9vEwkbQAyKjTJ8Ls
        JbLCmOY9syE7ahPE0zktist2c5oQuxm7e/SKZTh8r4RucX5KDP61MUd2SBQ8t7MycoQ/xXOe
        uSw1BF07XB5FJvUeODZQUnvswsLdOElQYP35efWNuIqZwMCZ30blitcV4taDjYTtXZ++4Ftu
        2JG8tWWtEw02oudgbjLBZ3W0YgtiYem/p0BoqaUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSnO62uIw4gx9veS2mN3pZzFm/hs2i
        e/NMRove96+YLFbu+cFkcXnXHDaLe2v+s1os+/qe3WJDyyx2i0cTJjFZnLr7md2B22PnrLvs
        HptWdbJ5bPo0id3jzrU9bB4nZvxm8Xi/7yqbR9+WVYweOz9tZvX4vEkugDOKyyYlNSezLLVI
        3y6BK+P/o17mgunKFQ+v/WJrYOyW7WLk5JAQMJHYeGYOSxcjF4eQwG5GiT3brjBDJGQk3px/
        CpTgALKFJQ4fLoao+coocWTvSzaQGjYBbYn3CyaxgiREBLYySnz4s54FJMEsUCnx7/YtVhBb
        WMBOYknTJbAGFgFViZZze9hAhvIK2Eo8elAHMV9eYuF/sLWcQNWf79xiBAkLAVVseGA5gZFv
        ASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4PDV0trBeOJE/CFGAQ5GJR7eF3Xp
        cUKsiWXFlbmHGCU4mJVEeOPlgUK8KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeWpGan
        phakFsFkmTg4pRoY2axspvbWH750z91t2ealXdc6YgtCgs8tXfyxcs3EPZaHsmwOVJ2eoruu
        UuYky7SVxqcN5kkvmC8ouODV5+PqXyvZU0wfFQaUGBWrGX6Sef3lna1SouFJZi9D3htPZgam
        Zpxb8NNZ+Kf/ryt8vBz1gnnBLfGy+uIiT9SLCmXCNK5zv2v/UntHiaU4I9FQi7moOBEAS3x9
        oFsCAAA=
X-CMS-MailID: 20200311034454epcas1p184680d40f89d37eec7f934074c4a9fcf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200311034454epcas1p184680d40f89d37eec7f934074c4a9fcf
References: <20200311034441.23243-1-jaewon31.kim@samsung.com>
        <CGME20200311034454epcas1p184680d40f89d37eec7f934074c4a9fcf@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide APIs to drivers so that they can show its memory usage on
/proc/meminfo.

int register_extra_meminfo(atomic_long_t *val, int shift,
			   const char *name);
int unregister_extra_meminfo(atomic_long_t *val);

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 fs/proc/meminfo.c  | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mm.h |   4 +++
 lib/show_mem.c     |   1 +
 3 files changed, 108 insertions(+)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 8c1f1bb1a5ce..12b1f77b091b 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -13,6 +13,7 @@
 #include <linux/vmstat.h>
 #include <linux/atomic.h>
 #include <linux/vmalloc.h>
+#include <linux/slab.h>
 #ifdef CONFIG_CMA
 #include <linux/cma.h>
 #endif
@@ -30,6 +31,106 @@ static void show_val_kb(struct seq_file *m, const char *s, unsigned long num)
 	seq_write(m, " kB\n", 4);
 }
 
+static LIST_HEAD(meminfo_head);
+static DEFINE_SPINLOCK(meminfo_lock);
+
+#define NAME_SIZE      15
+#define NAME_BUF_SIZE  (NAME_SIZE + 2) /* ':' and '\0' */
+
+struct extra_meminfo {
+	struct list_head list;
+	atomic_long_t *val;
+	int shift_for_page;
+	char name[NAME_BUF_SIZE];
+	char name_pad[NAME_BUF_SIZE];
+};
+
+int register_extra_meminfo(atomic_long_t *val, int shift, const char *name)
+{
+	struct extra_meminfo *meminfo, *memtemp;
+	int len;
+	int error = 0;
+
+	meminfo = kzalloc(sizeof(*meminfo), GFP_KERNEL);
+	if (!meminfo) {
+		error = -ENOMEM;
+		goto out;
+	}
+
+	meminfo->val = val;
+	meminfo->shift_for_page = shift;
+	strncpy(meminfo->name, name, NAME_SIZE);
+	len = strlen(meminfo->name);
+	meminfo->name[len] = ':';
+	strncpy(meminfo->name_pad, meminfo->name, NAME_BUF_SIZE);
+	while (++len < NAME_BUF_SIZE - 1)
+		meminfo->name_pad[len] = ' ';
+
+	spin_lock(&meminfo_lock);
+	list_for_each_entry(memtemp, &meminfo_head, list) {
+		if (memtemp->val == val) {
+			error = -EINVAL;
+			break;
+		}
+	}
+	if (!error)
+		list_add_tail(&meminfo->list, &meminfo_head);
+	spin_unlock(&meminfo_lock);
+	if (error)
+		kfree(meminfo);
+out:
+
+	return error;
+}
+EXPORT_SYMBOL(register_extra_meminfo);
+
+int unregister_extra_meminfo(atomic_long_t *val)
+{
+	struct extra_meminfo *memtemp, *memtemp2;
+	int error = -EINVAL;
+
+	spin_lock(&meminfo_lock);
+	list_for_each_entry_safe(memtemp, memtemp2, &meminfo_head, list) {
+		if (memtemp->val == val) {
+			list_del(&memtemp->list);
+			error = 0;
+			break;
+		}
+	}
+	spin_unlock(&meminfo_lock);
+	kfree(memtemp);
+
+	return error;
+}
+EXPORT_SYMBOL(unregister_extra_meminfo);
+
+static void __extra_meminfo(struct seq_file *m)
+{
+	struct extra_meminfo *memtemp;
+	unsigned long nr_page;
+
+	spin_lock(&meminfo_lock);
+	list_for_each_entry(memtemp, &meminfo_head, list) {
+		nr_page = (unsigned long)atomic_long_read(memtemp->val);
+		nr_page = nr_page >> memtemp->shift_for_page;
+		if (m)
+			show_val_kb(m, memtemp->name_pad, nr_page);
+		else
+			pr_cont("%s%lukB ", memtemp->name, nr_page);
+	}
+	spin_unlock(&meminfo_lock);
+}
+
+void extra_meminfo_log(void)
+{
+	__extra_meminfo(NULL);
+}
+
+static void extra_meminfo_proc(struct seq_file *m)
+{
+	__extra_meminfo(m);
+}
+
 static int meminfo_proc_show(struct seq_file *m, void *v)
 {
 	struct sysinfo i;
@@ -148,6 +249,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 	arch_report_meminfo(m);
 
+	extra_meminfo_proc(m);
+
 	return 0;
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c54fb96cb1e6..457570ddd17c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2902,6 +2902,10 @@ void __init setup_nr_node_ids(void);
 static inline void setup_nr_node_ids(void) {}
 #endif
 
+void extra_meminfo_log(void);
+int register_extra_meminfo(atomic_long_t *val, int shift, const char *name);
+int unregister_extra_meminfo(atomic_long_t *val);
+
 extern int memcmp_pages(struct page *page1, struct page *page2);
 
 static inline int pages_identical(struct page *page1, struct page *page2)
diff --git a/lib/show_mem.c b/lib/show_mem.c
index 1c26c14ffbb9..48be5afaca0a 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -14,6 +14,7 @@ void show_mem(unsigned int filter, nodemask_t *nodemask)
 	unsigned long total = 0, reserved = 0, highmem = 0;
 
 	printk("Mem-Info:\n");
+	extra_meminfo_log();
 	show_free_areas(filter, nodemask);
 
 	for_each_online_pgdat(pgdat) {
-- 
2.13.7

