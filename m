Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB09C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50A220848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pqB+BlbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCFAKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:10:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52848 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgCFAKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:10:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02608R7r051036;
        Fri, 6 Mar 2020 00:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1uqopwS4yz6Y2tWDAA94cnLce4rYml9GDblU748neAc=;
 b=pqB+BlbSWlpVQ4jDAE10GBlREt2L0DJER/JXIFdaVsoyVLf/rJS/yFcKEkQ7gPuDcn4b
 GCN7PtfXjqVru05ub1vFmBSbKD0WR5B6GfyA0xVn+IL3/s0ytHuhi9XU0XuP5/Z89cfR
 mXhz8FzFBRnI6ubsUAynZ3GVDE/8+3QB9xWiTsWdsmRf3VZ/Jqay7q2pB+uMcowSHblL
 rMXdcJQAdN7OkDjz6YfHMaaWLZNJscPhEYFDSvX0mE7VZKrx6Q+GoXoWVxzTNNH7zkgB
 DtmY9SUFsYwmAKQHDJL8y35JvKvnVfchdNiuPIv/mlYA9FMAi1fm+kHTjTITt+q/rwh8 /A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2yffcv0dk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Mar 2020 00:09:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02606flg176108;
        Fri, 6 Mar 2020 00:09:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yg1pbwj3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Mar 2020 00:09:46 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02609iCT032157;
        Fri, 6 Mar 2020 00:09:44 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Mar 2020 16:09:43 -0800
Subject: Re: [PATCH] mm/hugetlb: avoid weird message in hugetlb_init
To:     "Longpeng (Mike)" <longpeng2@huawei.com>
Cc:     arei.gonglei@huawei.com, huangzhichao@huawei.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200305033014.1152-1-longpeng2@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <fe9af2ff-01de-93ce-9628-10a54543be07@oracle.com>
Date:   Thu, 5 Mar 2020 16:09:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305033014.1152-1-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9551 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9551 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 7:30 PM, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
> 
> Some architectures(e.g. x86,risv) doesn't add 2M-hstate by default,
> so if we add 'default_hugepagesz=2M' but without 'hugepagesz=2M' in
> cmdline, we'll get a message as follow:
> "HugeTLB: unsupported default_hugepagesz 2097152. Reverting to 2097152"

Yes, that is a weird message that should not be printed.  Thanks for
pointing out the issue!

> As architecture-specific HPAGE_SIZE hstate should be supported by
> default, we can avoid this weird message by add it if we hadn't yet.

As you have discovered, some of the hugetlb size setup is done in
architecture specific code.  And other code is architecture independent.

The code which verifies huge page sizes (hugepagesz=) is architecture
specific.  The code which reads default_hugepagesz= is architecture
independent.  In fact, no verification of the 'default_hugepagesz' value
is made when value is read from the command line.  The value is verified
later after command line processing.  Current code considers the value
'valid' if it corresponds to a hstate previously setup by architecture
specific code.  If architecture specific code did not set up a corresponding 
hstate, an error like that above is reported.

Some architectures such as arm, powerpc and sparc set up hstates for all
supported sizes.  Other architectures such as riscv, s390 and x86 only
set up hstates for those requested on the command line with hugepagesz=.
Depending on config options, x86 and riscv may or may not set up PUD_SIZE
hstates.

Therefore, on s390 and x86 and riscv (with certain config options) it
would be possible to specify a valid huge page size (PUD_SIZE) with
default_hugepagesz=, and have that value be rejected.  This is because
the architecture specific code will not set up that hstate by default.

The code you have proposed handles the case where the value specified
by default_hugepagesz= coresponds to HPAGE_SIZE.  That is because the
architecture independent code will set up the hstate for HPAGE_SIZE.
HPAGE_SIZE is the only valid huge page size known by the architecture
independent code.

I am thinking we may want to have a more generic solution by allowing
the default_hugepagesz= processing code to verify the passed size and
set up the corresponding hstate.  This would require more cooperation
between architecture specific and independent code.  This could be
accomplished with a simple arch_hugetlb_valid_size() routine provided
by the architectures.  Below is an untested patch to add such support
to the architecture independent code and x86.  Other architectures would
be similar.

In addition, with architectures providing arch_hugetlb_valid_size() it
should be possible to have a common routine in architecture independent
code to read/process hugepagesz= command line arguments.

Of course, another approach would be to simply require ALL architectures
to set up hstates for ALL supported huge page sizes.

Thoughts?
-- 
Mike Kravetz

diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index f65cfb48cfdd..dc00c3df1f22 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -7,6 +7,9 @@
 
 #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
 
+#define __HAVE_ARCH_HUGETLB_VALID_SIZE
+extern bool __init arch_hugetlb_valid_size(unsigned long size);
+
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					 unsigned long addr,
 					 unsigned long len) {
diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 5bfd5aef5378..1c4372bfe782 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -181,13 +181,22 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_X86_64
+bool __init arch_hugetlb_valid_size(unsigned long size)
+{
+	if (size == PMD_SIZE)
+		return true;
+	else if (size == PUD_SIZE && boot_cpu_has(X86_FEATURE_GBPAGES))
+		return true;
+	else
+		return false;
+}
+
 static __init int setup_hugepagesz(char *opt)
 {
 	unsigned long ps = memparse(opt, &opt);
-	if (ps == PMD_SIZE) {
-		hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
-	} else if (ps == PUD_SIZE && boot_cpu_has(X86_FEATURE_GBPAGES)) {
-		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
+
+	if (arch_hugetlb_valid_size(ps)) {
+		hugetlb_add_hstate(ilog2(ps) - PAGE_SHIFT);
 	} else {
 		hugetlb_bad_size();
 		printk(KERN_ERR "hugepagesz: Unsupported page size %lu M\n",
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 50480d16bd33..822d0d8559c7 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -678,6 +678,13 @@ static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 	return &mm->page_table_lock;
 }
 
+#ifndef __HAVE_ARCH_HUGETLB_VALID_SIZE
+static inline bool arch_hugetlb_valid_size(unsigned long size)
+{
+	return (size == HPAGE_SIZE);
+}
+#endif
+
 #ifndef hugepages_supported
 /*
  * Some platform decide whether they support huge pages at boot
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7fb31750e670..fc3f0f1e3a27 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3078,17 +3078,13 @@ static int __init hugetlb_init(void)
 	if (!hugepages_supported())
 		return 0;
 
+	/* if default_hstate_size != 0, corresponding hstate was added */
 	if (!size_to_hstate(default_hstate_size)) {
-		if (default_hstate_size != 0) {
-			pr_err("HugeTLB: unsupported default_hugepagesz %lu. Reverting to %lu\n",
-			       default_hstate_size, HPAGE_SIZE);
-		}
-
 		default_hstate_size = HPAGE_SIZE;
-		if (!size_to_hstate(default_hstate_size))
-			hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
+		hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
 	}
 	default_hstate_idx = hstate_index(size_to_hstate(default_hstate_size));
+
 	if (default_hstate_max_huge_pages) {
 		if (!default_hstate.max_huge_pages)
 			default_hstate.max_huge_pages = default_hstate_max_huge_pages;
@@ -3195,7 +3191,15 @@ __setup("hugepages=", hugetlb_nrpages_setup);
 
 static int __init hugetlb_default_setup(char *s)
 {
-	default_hstate_size = memparse(s, &s);
+	unsigned long size = memparse(s, &s);
+
+	if (arch_hugetlb_valid_size(size)) {
+		default_hstate_size = size;
+		hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
+	} else {
+		pr_err("HugeTLB: unsupported default_hugepagesz %lu.\n", size);
+		hugetlb_bad_size();
+	}
 	return 1;
 }
 __setup("default_hugepagesz=", hugetlb_default_setup);
