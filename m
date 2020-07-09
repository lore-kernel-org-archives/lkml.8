Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DD6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BDFA207DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dVSVbGi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgGIQeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:34:23 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4465 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgGIQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:34:22 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0746d70000>; Thu, 09 Jul 2020 09:33:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 09 Jul 2020 09:34:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 09 Jul 2020 09:34:22 -0700
Received: from [10.2.168.64] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jul
 2020 16:34:18 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Hugh Dickins" <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4] mm/vmstat: Add events for THP migration without split
Date:   Thu, 9 Jul 2020 12:34:16 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <27CD781D-48F0-4019-934F-78994BAEC656@nvidia.com>
In-Reply-To: <cab90a5c-4c61-e9ad-659f-a9438d639fe5@infradead.org>
References: <1594287583-16568-1-git-send-email-anshuman.khandual@arm.com>
 <cab90a5c-4c61-e9ad-659f-a9438d639fe5@infradead.org>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_F60EA73D-8D00-4701-A4BB-277AC627A5CC_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594312407; bh=1/jJBTVfKcjlJZrHITpd75UYHwBpEDY2rEoyFlYDArM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=dVSVbGi7Nrqr+zbkHXkZ/dKyoxzicZ9g+go6AD2JlgGOSYw1D/3E1mODpmZXUNvRz
         ZlHKosxXy5g6QpEcfkvKdUYgFOijFijCUfSnu/gUsh3jZjrTNlY7ddeUEW1cpvTaso
         QX1rHoy8ZR1+P0zcx01NXu5APSfX8ZQFacgxA/utH4QMCj8/aoT1wNGZHP7KobWOdH
         iqCikHb1fSIweLoTdn3+DYf3Cd7H1YAwSE4CLYPhcYS17EdDQzRCXY+lETNOkoK/p7
         tKfFIzcduVxHrcaJvj9bhfWwPm09aU0fXN3niDuV+BUOH/FAGIJkeMi6mjpJXYhFXS
         AOTYfhJFk0X7w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_F60EA73D-8D00-4701-A4BB-277AC627A5CC_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 9 Jul 2020, at 11:34, Randy Dunlap wrote:

> Hi,
>
> I have a few comments on this.
>
> a. I reported it very early and should have been Cc-ed.
>
> b. A patch that applies to mmotm or linux-next would have been better
> than a full replacement patch.
>
> c. I tried replacing what I believe is the correct/same patch file in m=
motm
> and still have build errors.
>
> (more below)
>
> On 7/9/20 2:39 AM, Anshuman Khandual wrote:
>
>> ---
>> Applies on 5.8-rc4.
>>
>> Changes in V4:
>>
>> - Changed THP_MIGRATION_FAILURE as THP_MIGRATION_FAIL per John
>> - Dropped all conditional 'if' blocks in migrate_pages() per Andrew an=
d John
>> - Updated migration events documentation per John
>> - Updated thp_nr_pages variable as nr_subpages for an expected merge c=
onflict
>> - Moved all new THP vmstat events into CONFIG_MIGRATION
>> - Updated Cc list with Documentation/ and tracing related addresses
>>
>> Changes in V3: (https://patchwork.kernel.org/patch/11647237/)
>>
>> - Formatted new events documentation with 'fmt' tool per Matthew
>> - Made events universally available i.e dropped ARCH_ENABLE_THP_MIGRAT=
ION
>> - Added THP_MIGRATION_SPLIT
>> - Updated trace_mm_migrate_pages() with THP events
>> - Made THP events update normal page migration events as well
>>
>> Changes in V2: (https://patchwork.kernel.org/patch/11586893/)
>>
>> - Dropped PMD reference both from code and commit message per Matthew
>> - Added documentation and updated the commit message per Daniel
>>
>> Changes in V1: (https://patchwork.kernel.org/patch/11564497/)
>>
>> - Changed function name as thp_pmd_migration_success() per John
>> - Folded in a fix (https://patchwork.kernel.org/patch/11563009/) from =
Hugh
>>
>> Changes in RFC V2: (https://patchwork.kernel.org/patch/11554861/)
>>
>> - Decopupled and renamed VM events from their implementation per Zi an=
d John
>> - Added THP_PMD_MIGRATION_FAILURE VM event upon allocation failure and=
 split
>>
>> Changes in RFC V1: (https://patchwork.kernel.org/patch/11542055/)
>>
>>  Documentation/vm/page_migration.rst | 27 +++++++++++++++
>>  include/linux/vm_event_item.h       |  3 ++
>>  include/trace/events/migrate.h      | 17 ++++++++--
>>  mm/migrate.c                        | 52 ++++++++++++++++++++++++----=
-
>>  mm/vmstat.c                         |  3 ++
>>  5 files changed, 91 insertions(+), 11 deletions(-)
>>
>
>> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_it=
em.h
>> index 24fc7c3ae7d6..2e6ca53b9bbd 100644
>> --- a/include/linux/vm_event_item.h
>> +++ b/include/linux/vm_event_item.h
>> @@ -56,6 +56,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOU=
T,
>>  #endif
>>  #ifdef CONFIG_MIGRATION
>>  		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
>> +		THP_MIGRATION_SUCCESS,
>> +		THP_MIGRATION_FAIL,
>> +		THP_MIGRATION_SPLIT,
>
> These 3 new symbols are still only present if CONFIG_MIGRATION=3Dy, but=
 the build errors
> are using these symbols even when CONFIG_MIGRATION is not set.
>
>>  #endif
>>  #ifdef CONFIG_COMPACTION
>>  		COMPACTMIGRATE_SCANNED, COMPACTFREE_SCANNED,
>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index f37729673558..c706e3576cfc 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1429,22 +1429,35 @@ int migrate_pages(struct list_head *from, new_=
page_t get_new_page,
>>  		enum migrate_mode mode, int reason)
>>  {
>>  	int retry =3D 1;
>> +	int thp_retry =3D 1;
>>  	int nr_failed =3D 0;
>>  	int nr_succeeded =3D 0;
>> +	int nr_thp_succeeded =3D 0;
>> +	int nr_thp_failed =3D 0;
>> +	int nr_thp_split =3D 0;
>>  	int pass =3D 0;
>> +	bool is_thp =3D false;
>>  	struct page *page;
>>  	struct page *page2;
>>  	int swapwrite =3D current->flags & PF_SWAPWRITE;
>> -	int rc;
>> +	int rc, nr_subpages;
>>
>>  	if (!swapwrite)
>>  		current->flags |=3D PF_SWAPWRITE;
>>
>> -	for(pass =3D 0; pass < 10 && retry; pass++) {
>> +	for (pass =3D 0; pass < 10 && (retry || thp_retry); pass++) {
>>  		retry =3D 0;
>> +		thp_retry =3D 0;
>>
>>  		list_for_each_entry_safe(page, page2, from, lru) {
>>  retry:
>> +			/*
>> +			 * THP statistics is based on the source huge page.
>> +			 * Capture required information that might get lost
>> +			 * during migration.
>> +			 */
>> +			is_thp =3D PageTransHuge(page);
>> +			nr_subpages =3D hpage_nr_pages(page);
>>  			cond_resched();
>>
>>  			if (PageHuge(page))
>> @@ -1475,15 +1488,30 @@ int migrate_pages(struct list_head *from, new_=
page_t get_new_page,
>>  					unlock_page(page);
>>  					if (!rc) {
>>  						list_safe_reset_next(page, page2, lru);
>> +						nr_thp_split++;
>>  						goto retry;
>>  					}
>>  				}
>> +				if (is_thp) {
>> +					nr_thp_failed++;
>> +					nr_failed +=3D nr_subpages;
>> +					goto out;
>> +				}
>>  				nr_failed++;
>>  				goto out;
>>  			case -EAGAIN:
>> +				if (is_thp) {
>> +					thp_retry++;
>> +					break;
>> +				}
>>  				retry++;
>>  				break;
>>  			case MIGRATEPAGE_SUCCESS:
>> +				if (is_thp) {
>> +					nr_thp_succeeded++;
>> +					nr_succeeded +=3D nr_subpages;
>> +					break;
>> +				}
>>  				nr_succeeded++;
>>  				break;
>>  			default:
>> @@ -1493,19 +1521,27 @@ int migrate_pages(struct list_head *from, new_=
page_t get_new_page,
>>  				 * removed from migration page list and not
>>  				 * retried in the next outer loop.
>>  				 */
>> +				if (is_thp) {
>> +					nr_thp_failed++;
>> +					nr_failed +=3D nr_subpages;
>> +					break;
>> +				}
>>  				nr_failed++;
>>  				break;
>>  			}
>>  		}
>>  	}
>> -	nr_failed +=3D retry;
>> +	nr_failed +=3D retry + thp_retry;
>> +	nr_thp_failed +=3D thp_retry;
>>  	rc =3D nr_failed;
>>  out:
>> -	if (nr_succeeded)
>> -		count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>> -	if (nr_failed)
>> -		count_vm_events(PGMIGRATE_FAIL, nr_failed);
>> -	trace_mm_migrate_pages(nr_succeeded, nr_failed, mode, reason);
>> +	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>> +	count_vm_events(PGMIGRATE_FAIL, nr_failed);
>> +	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>> +	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>> +	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
>
> These references still cause build errors.
>
>> +	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
>> +			       nr_thp_failed, nr_thp_split, mode, reason);
>>
>>  	if (!swapwrite)
>>  		current->flags &=3D ~PF_SWAPWRITE;
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index 3fb23a21f6dd..09914a4bfee4 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1234,6 +1234,9 @@ const char * const vmstat_text[] =3D {
>>  #ifdef CONFIG_MIGRATION
>>  	"pgmigrate_success",
>>  	"pgmigrate_fail",
>> +	"thp_migration_success",
>> +	"thp_migration_fail",
>> +	"thp_migration_split",
>>  #endif
>>  #ifdef CONFIG_COMPACTION
>>  	"compact_migrate_scanned",
>>
>

Which arch are you building? I did not see any error
after applying this patch on mmotm (reverting the existing ones)
and compiling them on x86_64. I used make x86_64_defconfig and
unselected COMPACTION and MIGRATION.

mm/migrate.c and added vm events will not be used
if CONFIG_MIGRATION is unchecked. Why would they cause compilation errors=
?


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_F60EA73D-8D00-4701-A4BB-277AC627A5CC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl8HRwgPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKIesP/AgVeCChftpNKRZ07SX8+xw4Q3khJxCxNJyJ
s6DFiUQmAayYCkeeyNp8BzHeBaZmFOXH5PgFHE2/iOsdqGke0zVvN6w7ZgF3wJwV
nMiSYC7IZGsn3S2Mf0+JWoascFsiRpLQxgyOFwMSIYtiTARpmqU4FENaDv0qEeaf
2579pKK4mZhxkLmwrzsjy8YVRrm0Kc0wHhD4cjg2Ph1ZTslVMcAxMkoHgw3L9LPc
1NkFyJzZZ2yOTNgODySa2/b7sb8F75EBWK1Icrc8eM1teCNVpYja/gEm+On1G1vN
BBWf6m65ABqHpWB7jYNeBo4bUhfVNjex93IolNi0oVOX9PG6FlG3fzs8jKaRZPMA
XIryQZQ6ySbP7LST+TSSiJQGmt/xwkDW86JqVSrHNhg6IHQ3SCYNW97RXnEoGfLe
oEOaOveHExM0LDj/0zVHvrG8pxDTCxlp/t8IqC7tho5hYAKLc1iHsrvLIXN90s9o
rIZYE+xrhrD+QVltmtaN5GwOkVKS6ENtOWjLGzGFAhRQUYx3o16JxmtlrMqc1uHC
Ix3QqmCiBkl091NZaOdFViZECnuGuaBRJzReaqvUlmUIhH9DyPmKa5qCfBBDutpN
5y2RfduUxqWD99Eo+Dj2qCDum0pCU8igP6mEZFLfEG5zQWVg7uQgJ4JheuiOGo5+
ckOktc2j
=OReh
-----END PGP SIGNATURE-----

--=_MailMate_F60EA73D-8D00-4701-A4BB-277AC627A5CC_=--
