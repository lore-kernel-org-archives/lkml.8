Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2FAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 818842076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AyQ/CFmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgHKUOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:14:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725889AbgHKUOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:14:16 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07BK27fl160693;
        Tue, 11 Aug 2020 16:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ymwOzIn/WHaR13lGBFwwEePPes0F8FmXQ4eXAPvZjeI=;
 b=AyQ/CFmEF6IKGKVLuj+l8A36MMzLUNY3xIGjy0rKbkym5FuClorNyQKO6C++UFFAAJge
 EipJ+BTh/FBac4kn6dRBgZNEGQF2lEuSK0XLf25gkRyWEc3GBmwD2YIVuOB4qevhgXOE
 QSavTUdNH3XHwW2/4i2nf7cKtKqJnp993NYbnlqnhEioz4YtV27P1f4PuIldpz8QeB3M
 rFAvYIHhJCE0OrSUQLYj+Qsn9DPEfPK/5/5CYXz9JmsZYN7daHOXMpmOGdkBkhhOG/7K
 /iZuCGg/D6jBA6CTa4h0dGgwunnZmtC8XmxcSDu70GvNIJXgWx4ku6gDwXVgsVjarxz7 zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32uvjb1nbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 16:14:00 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07BK2Toj163169;
        Tue, 11 Aug 2020 16:14:00 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32uvjb1nav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 16:14:00 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07BK6AMg008912;
        Tue, 11 Aug 2020 20:13:58 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 32skp83ps0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 20:13:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07BKDukZ24904094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 20:13:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB985A405B;
        Tue, 11 Aug 2020 20:13:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3322A4054;
        Tue, 11 Aug 2020 20:13:54 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.85.161])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 11 Aug 2020 20:13:54 +0000 (GMT)
Date:   Tue, 11 Aug 2020 23:13:52 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Tony Luck <tony.luck@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Scheiner <frank.scheiner@web.de>
Subject: Re: [PATCH v2] arch/ia64: Restore arch-specific pgd_offset_k
 implementation
Message-ID: <20200811201352.GY163101@linux.ibm.com>
References: <fe587e09-2835-87b9-ceed-89cdb81f327c@physik.fu-berlin.de>
 <fa71f38e-b191-597a-6359-502cba197050@physik.fu-berlin.de>
 <AA5E212C-56ED-4DB9-9CC1-EB13745DD5AF@jrtc27.com>
 <20200811182457.57957-1-jrtc27@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811182457.57957-1-jrtc27@jrtc27.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_15:2020-08-11,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=1
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008110138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 07:24:57PM +0100, Jessica Clarke wrote:
> IA-64 is special and treats pgd_offset_k differently from pgd_offset by
> not including the region number, and init_mm's PGD is such that it only
> points to the kernel's region's PGD. This was broken in 974b9b2c68 which
> unified the two and therefore included the region number, causing it to
> go way out of bounds of the kernel's PGD, which made the kernel hang
> during early boot. Thus, permit pgd_offset_k to be overridden like the
> other macros and override it on IA-64 with the old implementation. Also
> update the comment to clarify that this is not just an optimisation but
> a required implementation detail.

If I may suggest:

IA-64 is special and treats pgd_offset_k() differently from pgd_offset() by
using different formulas to calculate index into kernel and user PGD
tables. The index into user PGDs takes into account the region number
and the index into the kernel (init_mm) PGD always presumes predefined
kernel region number. Commit 974b9b2c68 ("mm: consolidate pte_index()
and pte_offset_*() definitions") made IA-64 to use generic
pgd_offset_k() which wrongly used pgd_index() for user page tables. As
the result, the index into kernel PGD was going out of bounds and the
kernel hang during early boot.

Allow overrides of pgd_offset_k() and use an override on IA-64 with the
old implementation that will correctly index kernel PGD.

> Fixes: 974b9b2c68 ("mm: consolidate pte_index() and pte_offset_*() definitions")
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks for the fix, I don't insist on the changelog update, so with the
nit below

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> Changes since v1:
>  * Fixed typo in commit message
>  * Slightly reworded commit message to sound less weird
>  * Included Adrian's Tested-by
> 
>  arch/ia64/include/asm/pgtable.h | 8 ++++++++
>  include/linux/pgtable.h         | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
> index 10850897a91c..2ac2199d99ce 100644
> --- a/arch/ia64/include/asm/pgtable.h
> +++ b/arch/ia64/include/asm/pgtable.h
> @@ -366,6 +366,14 @@ pgd_index (unsigned long address)
>  }
>  #define pgd_index pgd_index
>  
> +/*
> + * In the kernel's mapped region we know everything is in region number 5, so
> + * as an optimisation its PGD already points to the area for that region, but
> + * that means not adding the region here is required, not just an optimisation.
> + */

How about:

/*
 * In the kernel's mapped region we know everything is in region number 5, so
 * as an optimisation its PGD already points to the area for that region.
 * However, this also means that we cannot use pgd_index() and we never
 * should add the region here.
 */

> +#define pgd_offset_k(addr) \
> +	(init_mm.pgd + (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1)))
> +
>  /* Look up a pgd entry in the gate area.  On IA-64, the gate-area
>     resides in the kernel-mapped segment, hence we use pgd_offset_k()
>     here.  */
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 53e97da1e8e2..73c64fe098ba 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -117,7 +117,9 @@ static inline pgd_t *pgd_offset_pgd(pgd_t *pgd, unsigned long address)
>   * a shortcut which implies the use of the kernel's pgd, instead
>   * of a process's
>   */
> +#ifndef pgd_offset_k
>  #define pgd_offset_k(address)		pgd_offset(&init_mm, (address))
> +#endif
>  
>  /*
>   * In many cases it is known that a virtual address is mapped at PMD or PTE
> -- 
> 2.23.0
> 

-- 
Sincerely yours,
Mike.
