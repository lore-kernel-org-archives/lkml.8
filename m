Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B8EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 01:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59A0206B9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 01:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="o4o69Jyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgDQBmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 21:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728799AbgDQBmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 21:42:44 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D0BC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 18:42:43 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id c12so180993qvj.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 18:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=44K4kvzQmLmmtltl44vFQsdVHoExSY93a7EeSDMao3U=;
        b=o4o69JydhPgE8CgciA7KxQ8qZCxszGnd7kgHv8C4HihvQylsBjUg58a/qRzsH6qU7L
         zL4YYyjp9mO4STrPgAog4pY7+q7CuR/F7iJduip/EBMqI/BNprd3/v7apQyKJlPIXnbo
         0CpbBALXivnBQFMz/NUkgpkKJrBaxQo6imoOnO3xuj3YrJ64RnKrAKKguy4tvmKHmTgq
         623d+3/8HScdOS7fbeLVPyRXAU+vn85W/kbKtWOcSVaBAYFla8kwPc8t53i34DEBkAKb
         iiFCC9tx24Jf1vOiyRT9iJChk2tTQHa+FS/5wcdyy0pygjSYcGUmRRUUHtaXxStB84rT
         /HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=44K4kvzQmLmmtltl44vFQsdVHoExSY93a7EeSDMao3U=;
        b=RI3RlxYsY4DUwbjYXrwPouES0MQZSs82qWVZ22+dlgQx47i/UPJ7m22ACuUAvfjdkg
         hvBhJP5BXavhmBxqU4Kmj5eU10rTQDNA5p65FRREvIukZ1l7pYo8k1NtIoDUxiryQXZO
         ClkAxYCIo0z91an6hMqK7fJ/zyNorvsUfQGTj8ltSQpmazydcFaBetb/jhgsZxcYp1se
         gmEJWfv8naGsTihiPPuUq31f1Omo4nKOC19Q8dvt5QtQdHYWHSslpEc2z4+9fuiTS0Ii
         YdpzWMLqtuXHfe19tvtGSuH+Qh6/M+EsZxemdkdcTNGekoN2bid4Jin/Eb7v47tBOg6K
         liqw==
X-Gm-Message-State: AGi0PuaUvR1pfeRheVDycO0nr+5f/k4xkfzFbL9bpr7fASVP7EciuMqT
        uw8gs+0VM8FTcprlMTaWMx6ip/fy6Kbd6A==
X-Google-Smtp-Source: APiQypKw5oVGluoPAce32z2q5BlgRaB/SEbpkG7LhAKSjD0SRBGvTF3Exco6zbpy6MaPax7ssof1ow==
X-Received: by 2002:a0c:ba83:: with SMTP id x3mr536005qvf.83.1587087763090;
        Thu, 16 Apr 2020 18:42:43 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u11sm4247523qtj.10.2020.04.16.18.42.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 18:42:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <527B0883-F59D-4C7A-8102-743872801EFC@lca.pw>
Date:   Thu, 16 Apr 2020 21:42:41 -0400
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FAF3A63-8DC8-4489-B5FE-95B716EF25AE@lca.pw>
References: <20200407021246.10941-1-cai@lca.pw>
 <7664E2E7-04D4-44C3-AB7E-A4334CDEC373@lca.pw>
 <20200408141915.GJ3103@8bytes.org>
 <527B0883-F59D-4C7A-8102-743872801EFC@lca.pw>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 13, 2020, at 9:36 PM, Qian Cai <cai@lca.pw> wrote:
>=20
>=20
>=20
>> On Apr 8, 2020, at 10:19 AM, Joerg Roedel <joro@8bytes.org> wrote:
>>=20
>> Hi Qian,
>>=20
>> On Tue, Apr 07, 2020 at 11:36:05AM -0400, Qian Cai wrote:
>>> After further testing, the change along is insufficient. What I am =
chasing right
>>> now is the swap device will go offline after heavy memory pressure =
below. The
>>> symptom is similar to what we have in the commit,
>>>=20
>>> 754265bcab78 (=E2=80=9Ciommu/amd: Fix race in =
increase_address_space()=E2=80=9D)
>>>=20
>>> Apparently, it is no possible to take the domain->lock in =
fetch_pte() because it
>>> could sleep.
>>=20
>> Thanks a lot for finding and tracking down another race in the AMD =
IOMMU
>> page-table code.  The domain->lock is a spin-lock and taking it can't
>> sleep. But fetch_pte() is a fast-path and must not take any locks.
>>=20
>> I think the best fix is to update the pt_root and mode of the domain
>> atomically by storing the mode in the lower 12 bits of pt_root. This =
way
>> they are stored together and can be read/write atomically.
>=20
> Like this?

So, this is still not enough that would still trigger storage driver =
offline under
memory pressure for a bit longer. It looks to me that in fetch_pte() =
there are
could still racy?

	level	   =3D  domain->mode - 1;
	pte	   =3D &domain->pt_root[PM_LEVEL_INDEX(level, address)];
							<=E2=80=94 =
increase_address_space();
	*page_size =3D  PTE_LEVEL_PAGE_SIZE(level);
=09
	while (level > 0) {
		*page_size =3D PTE_LEVEL_PAGE_SIZE(level);

Then in iommu_unmap_page(),

	while (unmapped < page_size) {
		pte =3D fetch_pte(dom, bus_addr, &unmap_size);
		=E2=80=A6
		bus_addr  =3D (bus_addr & ~(unmap_size - 1)) + =
unmap_size;

bus_addr would be unsync with dom->mode when it enter fetch_pte() again.
Could that be a problem?

>=20
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 20cce366e951..b36c6b07cbfd 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1397,13 +1397,13 @@ static struct page *free_sub_pt(unsigned long =
root, int mode,
>=20
> static void free_pagetable(struct protection_domain *domain)
> {
> -	unsigned long root =3D (unsigned long)domain->pt_root;
> +	int level =3D iommu_get_mode(domain->pt_root);
> +	unsigned long root =3D iommu_get_root(domain->pt_root);
> 	struct page *freelist =3D NULL;
>=20
> -	BUG_ON(domain->mode < PAGE_MODE_NONE ||
> -	       domain->mode > PAGE_MODE_6_LEVEL);
> +	BUG_ON(level < PAGE_MODE_NONE || level > PAGE_MODE_6_LEVEL);
>=20
> -	freelist =3D free_sub_pt(root, domain->mode, freelist);
> +	freelist =3D free_sub_pt(root, level, freelist);
>=20
> 	free_page_list(freelist);
> }
> @@ -1417,24 +1417,27 @@ static bool increase_address_space(struct =
protection_domain *domain,
> 				   unsigned long address,
> 				   gfp_t gfp)
> {
> +	int level;
> 	unsigned long flags;
> 	bool ret =3D false;
> 	u64 *pte;
>=20
> 	spin_lock_irqsave(&domain->lock, flags);
>=20
> -	if (address <=3D PM_LEVEL_SIZE(domain->mode) ||
> -	    WARN_ON_ONCE(domain->mode =3D=3D PAGE_MODE_6_LEVEL))
> +	level =3D iommu_get_mode(domain->pt_root);
> +
> +	if (address <=3D PM_LEVEL_SIZE(level) ||
> +	    WARN_ON_ONCE(level =3D=3D PAGE_MODE_6_LEVEL))
> 		goto out;
>=20
> 	pte =3D (void *)get_zeroed_page(gfp);
> 	if (!pte)
> 		goto out;
>=20
> -	*pte             =3D PM_LEVEL_PDE(domain->mode,
> -					=
iommu_virt_to_phys(domain->pt_root));
> -	domain->pt_root  =3D pte;
> -	domain->mode    +=3D 1;
> +	*pte =3D PM_LEVEL_PDE(level,
> +		iommu_virt_to_phys((void =
*)iommu_get_root(domain->pt_root)));
> +
> +	WRITE_ONCE(domain->pt_root, (unsigned long)pte + level + 1);
>=20
> 	ret =3D true;
>=20
> @@ -1452,15 +1455,17 @@ static u64 *alloc_pte(struct protection_domain =
*domain,
> 		      bool *updated)
> {
> 	int level, end_lvl;
> -	u64 *pte, *page;
> +	u64 *pte, *page, *pt_root, *root;
>=20
> 	BUG_ON(!is_power_of_2(page_size));
>=20
> -	while (address > PM_LEVEL_SIZE(domain->mode))
> +	while (address > PM_LEVEL_SIZE(iommu_get_mode(domain->pt_root)))
> 		*updated =3D increase_address_space(domain, address, =
gfp) || *updated;
>=20
> -	level   =3D domain->mode - 1;
> -	pte     =3D &domain->pt_root[PM_LEVEL_INDEX(level, address)];
> +	pt_root =3D READ_ONCE(domain->pt_root);
> +	root    =3D (void *)iommu_get_root(pt_root);
> +	level   =3D iommu_get_mode(pt_root) - 1;
> +	pte     =3D &root[PM_LEVEL_INDEX(level, address)];
> 	address =3D PAGE_SIZE_ALIGN(address, page_size);
> 	end_lvl =3D PAGE_SIZE_LEVEL(page_size);
>=20
> @@ -1536,16 +1541,18 @@ static u64 *fetch_pte(struct protection_domain =
*domain,
> 		      unsigned long address,
> 		      unsigned long *page_size)
> {
> -	int level;
> 	u64 *pte;
> +	u64 *pt_root =3D READ_ONCE(domain->pt_root);
> +	u64 *root    =3D (void *)iommu_get_root(pt_root);
> +	int level    =3D iommu_get_mode(pt_root);
>=20
> 	*page_size =3D 0;
>=20
> -	if (address > PM_LEVEL_SIZE(domain->mode))
> +	if (address > PM_LEVEL_SIZE(level))
> 		return NULL;
>=20
> -	level	   =3D  domain->mode - 1;
> -	pte	   =3D &domain->pt_root[PM_LEVEL_INDEX(level, address)];
> +	level--;
> +	pte	   =3D &root[PM_LEVEL_INDEX(level, address)];
> 	*page_size =3D  PTE_LEVEL_PAGE_SIZE(level);
>=20
> 	while (level > 0) {
> @@ -1814,12 +1821,13 @@ static struct protection_domain =
*dma_ops_domain_alloc(void)
> 	if (protection_domain_init(domain))
> 		goto free_domain;
>=20
> -	domain->mode =3D PAGE_MODE_3_LEVEL;
> 	domain->pt_root =3D (void *)get_zeroed_page(GFP_KERNEL);
> 	domain->flags =3D PD_DMA_OPS_MASK;
> 	if (!domain->pt_root)
> 		goto free_domain;
>=20
> +	domain->pt_root =3D iommu_set_mode(domain->pt_root, =
PAGE_MODE_3_LEVEL);
> +
> 	if (iommu_get_dma_cookie(&domain->domain) =3D=3D -ENOMEM)
> 		goto free_domain;
>=20
> @@ -1847,10 +1855,10 @@ static void set_dte_entry(u16 devid, struct =
protection_domain *domain,
> 	u64 flags =3D 0;
> 	u32 old_domid;
>=20
> -	if (domain->mode !=3D PAGE_MODE_NONE)
> -		pte_root =3D iommu_virt_to_phys(domain->pt_root);
> +	if (iommu_get_mode(domain->pt_root) !=3D PAGE_MODE_NONE)
> +		pte_root =3D iommu_virt_to_phys((void =
*)iommu_get_root(domain->pt_root));
>=20
> -	pte_root |=3D (domain->mode & DEV_ENTRY_MODE_MASK)
> +	pte_root |=3D ((unsigned long)domain->pt_root & =
DEV_ENTRY_MODE_MASK)
> 		    << DEV_ENTRY_MODE_SHIFT;
> 	pte_root |=3D DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | =
DTE_FLAG_TV;
>=20
> @@ -2382,13 +2390,14 @@ static struct iommu_domain =
*amd_iommu_domain_alloc(unsigned type)
> 		if (!pdomain)
> 			return NULL;
>=20
> -		pdomain->mode    =3D PAGE_MODE_3_LEVEL;
> 		pdomain->pt_root =3D (void =
*)get_zeroed_page(GFP_KERNEL);
> 		if (!pdomain->pt_root) {
> 			protection_domain_free(pdomain);
> 			return NULL;
> 		}
>=20
> +		pdomain->pt_root =3D iommu_set_mode(pdomain->pt_root,
> +						  PAGE_MODE_3_LEVEL);
> 		pdomain->domain.geometry.aperture_start =3D 0;
> 		pdomain->domain.geometry.aperture_end   =3D ~0ULL;
> 		pdomain->domain.geometry.force_aperture =3D true;
> @@ -2406,7 +2415,8 @@ static struct iommu_domain =
*amd_iommu_domain_alloc(unsigned type)
> 		if (!pdomain)
> 			return NULL;
>=20
> -		pdomain->mode =3D PAGE_MODE_NONE;
> +		pdomain->pt_root =3D iommu_set_mode(pdomain->pt_root,
> +						  PAGE_MODE_NONE);
> 		break;
> 	default:
> 		return NULL;
> @@ -2435,7 +2445,7 @@ static void amd_iommu_domain_free(struct =
iommu_domain *dom)
> 		dma_ops_domain_free(domain);
> 		break;
> 	default:
> -		if (domain->mode !=3D PAGE_MODE_NONE)
> +		if (iommu_get_mode(domain->pt_root) !=3D PAGE_MODE_NONE)
> 			free_pagetable(domain);
>=20
> 		if (domain->flags & PD_IOMMUV2_MASK)
> @@ -2521,7 +2531,7 @@ static int amd_iommu_map(struct iommu_domain =
*dom, unsigned long iova,
> 	int prot =3D 0;
> 	int ret;
>=20
> -	if (domain->mode =3D=3D PAGE_MODE_NONE)
> +	if (iommu_get_mode(domain->pt_root) =3D=3D PAGE_MODE_NONE)
> 		return -EINVAL;
>=20
> 	if (iommu_prot & IOMMU_READ)
> @@ -2542,7 +2552,7 @@ static size_t amd_iommu_unmap(struct =
iommu_domain *dom, unsigned long iova,
> {
> 	struct protection_domain *domain =3D to_pdomain(dom);
>=20
> -	if (domain->mode =3D=3D PAGE_MODE_NONE)
> +	if (iommu_get_mode(domain->pt_root) =3D=3D PAGE_MODE_NONE)
> 		return 0;
>=20
> 	return iommu_unmap_page(domain, iova, page_size);
> @@ -2555,7 +2565,7 @@ static phys_addr_t amd_iommu_iova_to_phys(struct =
iommu_domain *dom,
> 	unsigned long offset_mask, pte_pgsize;
> 	u64 *pte, __pte;
>=20
> -	if (domain->mode =3D=3D PAGE_MODE_NONE)
> +	if (iommu_get_mode(domain->pt_root) =3D=3D PAGE_MODE_NONE)
> 		return iova;
>=20
> 	pte =3D fetch_pte(domain, iova, &pte_pgsize);
> @@ -2713,7 +2723,7 @@ void amd_iommu_domain_direct_map(struct =
iommu_domain *dom)
> 	spin_lock_irqsave(&domain->lock, flags);
>=20
> 	/* Update data structure */
> -	domain->mode    =3D PAGE_MODE_NONE;
> +	domain->pt_root =3D iommu_set_mode(domain->pt_root, =
PAGE_MODE_NONE);
>=20
> 	/* Make changes visible to IOMMUs */
> 	update_domain(domain);
> @@ -2910,7 +2920,7 @@ static int __set_gcr3(struct protection_domain =
*domain, int pasid,
> {
> 	u64 *pte;
>=20
> -	if (domain->mode !=3D PAGE_MODE_NONE)
> +	if (iommu_get_mode(domain->pt_root) !=3D PAGE_MODE_NONE)
> 		return -EINVAL;
>=20
> 	pte =3D __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, =
true);
> @@ -2926,7 +2936,7 @@ static int __clear_gcr3(struct protection_domain =
*domain, int pasid)
> {
> 	u64 *pte;
>=20
> -	if (domain->mode !=3D PAGE_MODE_NONE)
> +	if (iommu_get_mode(domain->pt_root) !=3D PAGE_MODE_NONE)
> 		return -EINVAL;
>=20
> 	pte =3D __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, =
false);
> diff --git a/drivers/iommu/amd_iommu_proto.h =
b/drivers/iommu/amd_iommu_proto.h
> index 92c2ba6468a0..34d4dd66cf9b 100644
> --- a/drivers/iommu/amd_iommu_proto.h
> +++ b/drivers/iommu/amd_iommu_proto.h
> @@ -67,6 +67,21 @@ static inline int =
amd_iommu_create_irq_domain(struct amd_iommu *iommu)
> extern int amd_iommu_complete_ppr(struct pci_dev *pdev, int pasid,
> 				  int status, int tag);
>=20
> +static inline int iommu_get_mode(void *pt_root)
> +{
> +	return (unsigned long)pt_root & ~PAGE_MASK;
> +}
> +
> +static inline unsigned long iommu_get_root(void *pt_root)
> +{
> +	return (unsigned long)pt_root & PAGE_MASK;
> +}
> +
> +static inline void *iommu_set_mode(void *pt_root, int mode)
> +{
> +	return (void *)(iommu_get_root(pt_root) + mode);
> +}
> +
> static inline bool is_rd890_iommu(struct pci_dev *pdev)
> {
> 	return (pdev->vendor =3D=3D PCI_VENDOR_ID_ATI) &&
> diff --git a/drivers/iommu/amd_iommu_types.h =
b/drivers/iommu/amd_iommu_types.h
> index ca8c4522045b..221adefa56a0 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -468,8 +468,8 @@ struct protection_domain {
> 				       iommu core code */
> 	spinlock_t lock;	/* mostly used to lock the page table*/
> 	u16 id;			/* the domain id written to the device =
table */
> -	int mode;		/* paging mode (0-6 levels) */
> -	u64 *pt_root;		/* page table root pointer */
> +	u64 *pt_root;		/* page table root pointer and paging =
mode (0-6
> +				   levels) */
> 	int glx;		/* Number of levels for GCR3 table */
> 	u64 *gcr3_tbl;		/* Guest CR3 table */
> 	unsigned long flags;	/* flags to find out type of domain */
> --=20
> 2.21.0 (Apple Git-122.2)

