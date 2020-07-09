Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635F3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E7F207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="g2wX4bqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgGIRmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:42:15 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10782 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgGIRmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:42:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0756be0000>; Thu, 09 Jul 2020 10:41:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 09 Jul 2020 10:42:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 09 Jul 2020 10:42:13 -0700
Received: from [10.2.168.64] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jul
 2020 17:42:09 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4] mm/vmstat: Add events for THP migration without split
Date:   Thu, 9 Jul 2020 13:42:07 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <C5E3C65C-8253-4638-9D3C-71A61858BB8B@nvidia.com>
In-Reply-To: <97219d3b-96e1-4371-59ea-d038f37a672a@infradead.org>
References: <1594287583-16568-1-git-send-email-anshuman.khandual@arm.com>
 <cab90a5c-4c61-e9ad-659f-a9438d639fe5@infradead.org>
 <27CD781D-48F0-4019-934F-78994BAEC656@nvidia.com>
 <97219d3b-96e1-4371-59ea-d038f37a672a@infradead.org>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_FD1204B2-7E17-457B-A451-640149E14B1C_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594316479; bh=moSQkyvnd9E9hWgCqs6HLsWPvn2WtTAR0dQhJxkhoo8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=g2wX4bqq28SWZyuNyWpLULBNrVNoq/lO5VCH97Au9pLNkgcxC9h3QDqTF7y005oVF
         ULjoe1fFk0IT6rXrqS2cXle7ajDc9avDOtKCVGzfuL182rLjnsimUq4zlN4gjgsWsc
         4T3YZ63rt19fCXvTwW+q4cHTKcG4ch97aIBx+agrl/s9yjvt3Oon9+AfC/pzUEs4Mn
         vggiB/ffyj31vcn8Uu+t1Tllm8JvIFbmm1dKRiuws5gw/L8TXqRreGH78KMTTnRBqq
         rFWa8xOvNpSVJOj5LHZv3YN1MjDeoF/gBSUOASlmZZWIF+R+YeYPtEvrcUJZEZ+Ctt
         xbfFV+CvgQ4PQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_FD1204B2-7E17-457B-A451-640149E14B1C_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 9 Jul 2020, at 12:39, Randy Dunlap wrote:

> On 7/9/20 9:34 AM, Zi Yan wrote:
>> On 9 Jul 2020, at 11:34, Randy Dunlap wrote:
>>
>>> Hi,
>>>
>>> I have a few comments on this.
>>>
>>> a. I reported it very early and should have been Cc-ed.
>>>
>>> b. A patch that applies to mmotm or linux-next would have been better=

>>> than a full replacement patch.
>>>
>>> c. I tried replacing what I believe is the correct/same patch file in=
 mmotm
>>> and still have build errors.
>>>
>>> (more below)
>>>
>>> On 7/9/20 2:39 AM, Anshuman Khandual wrote:
>>>
>>>> ---
>>>> Applies on 5.8-rc4.
>>>>
>>>> Changes in V4:
>>>>
>>>> - Changed THP_MIGRATION_FAILURE as THP_MIGRATION_FAIL per John
>>>> - Dropped all conditional 'if' blocks in migrate_pages() per Andrew =
and John
>>>> - Updated migration events documentation per John
>>>> - Updated thp_nr_pages variable as nr_subpages for an expected merge=
 conflict
>>>> - Moved all new THP vmstat events into CONFIG_MIGRATION
>>>> - Updated Cc list with Documentation/ and tracing related addresses
>>>>
>>>> Changes in V3: (https://patchwork.kernel.org/patch/11647237/)
>>>>
>>>> - Formatted new events documentation with 'fmt' tool per Matthew
>>>> - Made events universally available i.e dropped ARCH_ENABLE_THP_MIGR=
ATION
>>>> - Added THP_MIGRATION_SPLIT
>>>> - Updated trace_mm_migrate_pages() with THP events
>>>> - Made THP events update normal page migration events as well
>>>>
>>>> Changes in V2: (https://patchwork.kernel.org/patch/11586893/)
>>>>
>>>> - Dropped PMD reference both from code and commit message per Matthe=
w
>>>> - Added documentation and updated the commit message per Daniel
>>>>
>>>> Changes in V1: (https://patchwork.kernel.org/patch/11564497/)
>>>>
>>>> - Changed function name as thp_pmd_migration_success() per John
>>>> - Folded in a fix (https://patchwork.kernel.org/patch/11563009/) fro=
m Hugh
>>>>
>>>> Changes in RFC V2: (https://patchwork.kernel.org/patch/11554861/)
>>>>
>>>> - Decopupled and renamed VM events from their implementation per Zi =
and John
>>>> - Added THP_PMD_MIGRATION_FAILURE VM event upon allocation failure a=
nd split
>>>>
>>>> Changes in RFC V1: (https://patchwork.kernel.org/patch/11542055/)
>>>>
>>>>  Documentation/vm/page_migration.rst | 27 +++++++++++++++
>>>>  include/linux/vm_event_item.h       |  3 ++
>>>>  include/trace/events/migrate.h      | 17 ++++++++--
>>>>  mm/migrate.c                        | 52 ++++++++++++++++++++++++--=
---
>>>>  mm/vmstat.c                         |  3 ++
>>>>  5 files changed, 91 insertions(+), 11 deletions(-)
>>>>
>>>
>>>> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_=
item.h
>>>> index 24fc7c3ae7d6..2e6ca53b9bbd 100644
>>>> --- a/include/linux/vm_event_item.h
>>>> +++ b/include/linux/vm_event_item.h
>>>> @@ -56,6 +56,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWP=
OUT,
>>>>  #endif
>>>>  #ifdef CONFIG_MIGRATION
>>>>  		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
>>>> +		THP_MIGRATION_SUCCESS,
>>>> +		THP_MIGRATION_FAIL,
>>>> +		THP_MIGRATION_SPLIT,
>>>
>>> These 3 new symbols are still only present if CONFIG_MIGRATION=3Dy, b=
ut the build errors
>>> are using these symbols even when CONFIG_MIGRATION is not set.
>>>
>>>>  #endif
>>>>  #ifdef CONFIG_COMPACTION
>>>>  		COMPACTMIGRATE_SCANNED, COMPACTFREE_SCANNED,
>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index f37729673558..c706e3576cfc 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1429,22 +1429,35 @@ int migrate_pages(struct list_head *from, ne=
w_page_t get_new_page,
>>>>  		enum migrate_mode mode, int reason)
>>>>  {
>>>>  	int retry =3D 1;
>>>> +	int thp_retry =3D 1;
>>>>  	int nr_failed =3D 0;
>>>>  	int nr_succeeded =3D 0;
>>>> +	int nr_thp_succeeded =3D 0;
>>>> +	int nr_thp_failed =3D 0;
>>>> +	int nr_thp_split =3D 0;
>>>>  	int pass =3D 0;
>>>> +	bool is_thp =3D false;
>>>>  	struct page *page;
>>>>  	struct page *page2;
>>>>  	int swapwrite =3D current->flags & PF_SWAPWRITE;
>>>> -	int rc;
>>>> +	int rc, nr_subpages;
>>>>
>>>>  	if (!swapwrite)
>>>>  		current->flags |=3D PF_SWAPWRITE;
>>>>
>>>> -	for(pass =3D 0; pass < 10 && retry; pass++) {
>>>> +	for (pass =3D 0; pass < 10 && (retry || thp_retry); pass++) {
>>>>  		retry =3D 0;
>>>> +		thp_retry =3D 0;
>>>>
>>>>  		list_for_each_entry_safe(page, page2, from, lru) {
>>>>  retry:
>>>> +			/*
>>>> +			 * THP statistics is based on the source huge page.
>>>> +			 * Capture required information that might get lost
>>>> +			 * during migration.
>>>> +			 */
>>>> +			is_thp =3D PageTransHuge(page);
>>>> +			nr_subpages =3D hpage_nr_pages(page);
>>>>  			cond_resched();
>>>>
>>>>  			if (PageHuge(page))
>>>> @@ -1475,15 +1488,30 @@ int migrate_pages(struct list_head *from, ne=
w_page_t get_new_page,
>>>>  					unlock_page(page);
>>>>  					if (!rc) {
>>>>  						list_safe_reset_next(page, page2, lru);
>>>> +						nr_thp_split++;
>>>>  						goto retry;
>>>>  					}
>>>>  				}
>>>> +				if (is_thp) {
>>>> +					nr_thp_failed++;
>>>> +					nr_failed +=3D nr_subpages;
>>>> +					goto out;
>>>> +				}
>>>>  				nr_failed++;
>>>>  				goto out;
>>>>  			case -EAGAIN:
>>>> +				if (is_thp) {
>>>> +					thp_retry++;
>>>> +					break;
>>>> +				}
>>>>  				retry++;
>>>>  				break;
>>>>  			case MIGRATEPAGE_SUCCESS:
>>>> +				if (is_thp) {
>>>> +					nr_thp_succeeded++;
>>>> +					nr_succeeded +=3D nr_subpages;
>>>> +					break;
>>>> +				}
>>>>  				nr_succeeded++;
>>>>  				break;
>>>>  			default:
>>>> @@ -1493,19 +1521,27 @@ int migrate_pages(struct list_head *from, ne=
w_page_t get_new_page,
>>>>  				 * removed from migration page list and not
>>>>  				 * retried in the next outer loop.
>>>>  				 */
>>>> +				if (is_thp) {
>>>> +					nr_thp_failed++;
>>>> +					nr_failed +=3D nr_subpages;
>>>> +					break;
>>>> +				}
>>>>  				nr_failed++;
>>>>  				break;
>>>>  			}
>>>>  		}
>>>>  	}
>>>> -	nr_failed +=3D retry;
>>>> +	nr_failed +=3D retry + thp_retry;
>>>> +	nr_thp_failed +=3D thp_retry;
>>>>  	rc =3D nr_failed;
>>>>  out:
>>>> -	if (nr_succeeded)
>>>> -		count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>>>> -	if (nr_failed)
>>>> -		count_vm_events(PGMIGRATE_FAIL, nr_failed);
>>>> -	trace_mm_migrate_pages(nr_succeeded, nr_failed, mode, reason);
>>>> +	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>>>> +	count_vm_events(PGMIGRATE_FAIL, nr_failed);
>>>> +	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>>>> +	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>>>> +	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
>>>
>>> These references still cause build errors.
>>>
>>>> +	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
>>>> +			       nr_thp_failed, nr_thp_split, mode, reason);
>>>>
>>>>  	if (!swapwrite)
>>>>  		current->flags &=3D ~PF_SWAPWRITE;
>>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>>> index 3fb23a21f6dd..09914a4bfee4 100644
>>>> --- a/mm/vmstat.c
>>>> +++ b/mm/vmstat.c
>>>> @@ -1234,6 +1234,9 @@ const char * const vmstat_text[] =3D {
>>>>  #ifdef CONFIG_MIGRATION
>>>>  	"pgmigrate_success",
>>>>  	"pgmigrate_fail",
>>>> +	"thp_migration_success",
>>>> +	"thp_migration_fail",
>>>> +	"thp_migration_split",
>>>>  #endif
>>>>  #ifdef CONFIG_COMPACTION
>>>>  	"compact_migrate_scanned",
>>>>
>>>
>>
>> Which arch are you building? I did not see any error
>> after applying this patch on mmotm (reverting the existing ones)
>> and compiling them on x86_64. I used make x86_64_defconfig and
>> unselected COMPACTION and MIGRATION.
>
> Hi,
>
> I am trying to build x86_64.
> Maybe I am just having trouble replacing the patch file.
> Like I tried to say, I would prefer to see an incremental patch
> to fix mmotm or linux-next.

I agree. The patch does not apply to mmotm. Can you try the incremental
patch below? It should apply to mmotm.


Hi Andrew and Anshuman,

Should Anshuman resend the incremental patch or Andrew can fold it along
with the two patches in mmotm into one?


diff --git a/Documentation/vm/page_migration.rst b/Documentation/vm/page_=
migration.rst
index e65d49f3cf86..68883ac485fa 100644
--- a/Documentation/vm/page_migration.rst
+++ b/Documentation/vm/page_migration.rst
@@ -253,24 +253,32 @@ which are function pointers of struct address_space=
_operations.
      PG_isolated is alias with PG_reclaim flag so driver shouldn't use t=
he flag
      for own purpose.

-Quantifying Migration
+Monitoring Migration
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-Following events can be used to quantify page migration.
-
-1. PGMIGRATE_SUCCESS       /* Normal page migration success */
-2. PGMIGRATE_FAIL          /* Normal page migration failure */
-3. THP_MIGRATION_SUCCESS   /* Transparent huge page migration success */=

-4. THP_MIGRATION_FAILURE   /* Transparent huge page migration failure */=

-5. THP_MIGRATION_SPLIT     /* Transparent huge page got split, retried *=
/
-
-THP_MIGRATION_SUCCESS is when THP is migrated successfully without getti=
ng
-split into it's subpages. THP_MIGRATION_FAILURE is when THP could neithe=
r
-be migrated nor be split. THP_MIGRATION_SPLIT is when THP could not
-just be migrated as is but instead get split into it's subpages and late=
r
-retried as normal pages. THP events would also update normal page migrat=
ion
-statistics PGMIGRATE_SUCCESS and PGMIGRATE_FAILURE. These events will he=
lp
-in quantifying and analyzing various THP migration events including both=

-success and failure cases.
+
+The following events (counters) can be used to monitor page migration.
+
+1. PGMIGRATE_SUCCESS: Normal page migration success. Each count means th=
at a
+   page was migrated. If the page was a non-THP page, then this counter =
is
+   increased by one. If the page was a THP, then this counter is increas=
ed by
+   the number of THP subpages. For example, migration of a single 2MB TH=
P that
+   has 4KB-size base pages (subpages) will cause this counter to increas=
e by
+   512.
+
+2. PGMIGRATE_FAIL: Normal page migration failure. Same counting rules as=
 for
+   _SUCCESS, above: this will be increased by the number of subpages, if=
 it was
+   a THP.
+
+3. THP_MIGRATION_SUCCESS: A THP was migrated without being split.
+
+4. THP_MIGRATION_FAIL: A THP could not be migrated nor it could be split=
=2E
+
+5. THP_MIGRATION_SPLIT: A THP was migrated, but not as such: first, the =
THP had
+   to be split. After splitting, a migration retry was used for it's sub=
-pages.
+
+THP_MIGRATION_* events also update the appropriate PGMIGRATE_SUCCESS or
+PGMIGRATE_FAIL events. For example, a THP migration failure will cause b=
oth
+THP_MIGRATION_FAIL and PGMIGRATE_FAIL to increase.

 Christoph Lameter, May 8, 2006.
 Minchan Kim, Mar 28, 2016.
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.=
h
index 5e7ffa025589..2e6ca53b9bbd 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -56,6 +56,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #endif
 #ifdef CONFIG_MIGRATION
 		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
+		THP_MIGRATION_SUCCESS,
+		THP_MIGRATION_FAIL,
+		THP_MIGRATION_SPLIT,
 #endif
 #ifdef CONFIG_COMPACTION
 		COMPACTMIGRATE_SCANNED, COMPACTFREE_SCANNED,
@@ -95,9 +98,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_ZERO_PAGE_ALLOC_FAILED,
 		THP_SWPOUT,
 		THP_SWPOUT_FALLBACK,
-		THP_MIGRATION_SUCCESS,
-		THP_MIGRATION_FAILURE,
-		THP_MIGRATION_SPLIT,
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
 		BALLOON_INFLATE,
diff --git a/mm/migrate.c b/mm/migrate.c
index b0125c082549..c6cb8e676f9d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1425,7 +1425,7 @@ int migrate_pages(struct list_head *from, new_page_=
t get_new_page,
 	struct page *page;
 	struct page *page2;
 	int swapwrite =3D current->flags & PF_SWAPWRITE;
-	int rc, thp_n_pages;
+	int rc, nr_subpages;

 	if (!swapwrite)
 		current->flags |=3D PF_SWAPWRITE;
@@ -1442,7 +1442,7 @@ int migrate_pages(struct list_head *from, new_page_=
t get_new_page,
 			 * during migration.
 			 */
 			is_thp =3D PageTransHuge(page);
-			thp_n_pages =3D thp_nr_pages(page);
+			nr_subpages =3D thp_nr_pages(page);
 			cond_resched();

 			if (PageHuge(page))
@@ -1479,7 +1479,7 @@ int migrate_pages(struct list_head *from, new_page_=
t get_new_page,
 				}
 				if (is_thp) {
 					nr_thp_failed++;
-					nr_failed +=3D thp_n_pages;
+					nr_failed +=3D nr_subpages;
 					goto out;
 				}
 				nr_failed++;
@@ -1494,7 +1494,7 @@ int migrate_pages(struct list_head *from, new_page_=
t get_new_page,
 			case MIGRATEPAGE_SUCCESS:
 				if (is_thp) {
 					nr_thp_succeeded++;
-					nr_succeeded +=3D thp_n_pages;
+					nr_succeeded +=3D nr_subpages;
 					break;
 				}
 				nr_succeeded++;
@@ -1508,7 +1508,7 @@ int migrate_pages(struct list_head *from, new_page_=
t get_new_page,
 				 */
 				if (is_thp) {
 					nr_thp_failed++;
-					nr_failed +=3D thp_n_pages;
+					nr_failed +=3D nr_subpages;
 					break;
 				}
 				nr_failed++;
@@ -1520,16 +1520,11 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
 	nr_thp_failed +=3D thp_retry;
 	rc =3D nr_failed;
 out:
-	if (nr_succeeded)
-		count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
-	if (nr_failed)
-		count_vm_events(PGMIGRATE_FAIL, nr_failed);
-	if (nr_thp_succeeded)
-		count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
-	if (nr_thp_failed)
-		count_vm_events(THP_MIGRATION_FAILURE, nr_thp_failed);
-	if (nr_thp_split)
-		count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
+	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
+	count_vm_events(PGMIGRATE_FAIL, nr_failed);
+	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
+	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
+	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
 	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
 			       nr_thp_failed, nr_thp_split, mode, reason);

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 9892090df6a2..a21140373edb 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1274,6 +1274,9 @@ const char * const vmstat_text[] =3D {
 #ifdef CONFIG_MIGRATION
 	"pgmigrate_success",
 	"pgmigrate_fail",
+	"thp_migration_success",
+	"thp_migration_fail",
+	"thp_migration_split",
 #endif
 #ifdef CONFIG_COMPACTION
 	"compact_migrate_scanned",
@@ -1320,9 +1323,6 @@ const char * const vmstat_text[] =3D {
 	"thp_zero_page_alloc_failed",
 	"thp_swpout",
 	"thp_swpout_fallback",
-	"thp_migration_success",
-	"thp_migration_failure",
-	"thp_migration_split",
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
 	"balloon_inflate",




=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_FD1204B2-7E17-457B-A451-640149E14B1C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl8HVu8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK6p8P/0SaawUX10trQBUdmLSSCzKidwo4zGf1LD60
Cb5AAx/ZGkVfGZrBgnMmIhQUuWHKpQPIEsXUyY112Hicua58QFS5DAjwso476fss
h5+dXqFVMnup65SJLwMXAE5N6OBAj7dKu0wvV9SjJMcSfVKMkn+PRdV4DuI6n/kW
+Eb67pWDGxxfdXZgqJY8uoyEVRRKKwaep/3otn4ZPayK9sH33GwpP9ICX7EIrUxW
58rANu3j69AU0PhMofBJcmQ8VTuvrcUEyb8AeIlMqJmCIyH7/l9qqBYMPKAnAcFX
rEzKTM38Kte92tjvJW8TZo6WtaYKlND+8tBakIN1ifxXRWty/7JiQ9Yw0znffHsm
bkaOjroUdMA6k2wcvW6+uv4koX7ZMuScejobmVnRFumOh6zZkqTa261UjVcjbN8U
P+MKhzBZSAJZWzZK/Gy/lkqxlu5o6J0T2R9uabbdZxdRrr64xCCf4XBt+eCM7v+O
stqFXjy2SI+M2oCuecFV3xDelfsWtnkF+5zRkGCDw9l9qeloQ4Ryp0PLlAyDMRNN
yCnyARst1YTHn2iaqaJ3oCQgOBCylrsu3MJcSzUiM+B9iqBpM2VLO51iAHbzU6jV
LRVreOsFDS1trHNIS677axDnmaHgafmK8GFGMwbkdTZm9BO68FurkmBBFPeDqM5F
peuqKuhh
=zNZb
-----END PGP SIGNATURE-----

--=_MailMate_FD1204B2-7E17-457B-A451-640149E14B1C_=--
