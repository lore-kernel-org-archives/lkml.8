Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0467C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894A7206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgDGLK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:10:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728333AbgDGLKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:10:52 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037B4imE108346
        for <linux-kernel@vger.kernel.org>; Tue, 7 Apr 2020 07:10:51 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3082j8mv1g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:10:51 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Tue, 7 Apr 2020 12:10:22 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Apr 2020 12:10:19 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 037BAio653936380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Apr 2020 11:10:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CA03A4054;
        Tue,  7 Apr 2020 11:10:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00ACEA4060;
        Tue,  7 Apr 2020 11:10:44 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.8.150])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Apr 2020 11:10:43 +0000 (GMT)
Date:   Tue, 7 Apr 2020 13:05:22 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 3/5] KVM: s390: vsie: Fix possible race when
 shadowing region 3 tables
In-Reply-To: <20200403153050.20569-4-david@redhat.com>
References: <20200403153050.20569-1-david@redhat.com>
        <20200403153050.20569-4-david@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20040711-0020-0000-0000-000003C33E85
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040711-0021-0000-0000-0000221BFC1A
Message-Id: <20200407130522.189a9a3f@p-imbrenda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_03:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=2 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Apr 2020 17:30:48 +0200
David Hildenbrand <david@redhat.com> wrote:

> We have to properly retry again by returning -EINVAL immediately in
> case somebody else instantiated the table concurrently. We missed to
> add the goto in this function only. The code now matches the other,
> similar shadowing functions.
> 
> We are overwriting an existing region 2 table entry. All allocated
> pages are added to the crst_list to be freed later, so they are not
> lost forever. However, when unshadowing the region 2 table, we
> wouldn't trigger unshadowing of the original shadowed region 3 table
> that we replaced. It would get unshadowed when the original region 3
> table is modified. As it's not connected to the page table hierarchy
> anymore, it's not going to get used anymore. However, for a limited
> time, this page table will stick around, so it's in some sense a
> temporary memory leak.
> 
> Identified by manual code inspection. I don't think this classifies as
> stable material.
> 
> Fixes: 998f637cc4b9 ("s390/mm: avoid races on region/segment/page
> table shadowing") Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/mm/gmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index b93dd54b234a..24ef30fb0833 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -1844,6 +1844,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned
> long saddr, unsigned long r3t, goto out_free;
>  	} else if (*table & _REGION_ENTRY_ORIGIN) {
>  		rc = -EAGAIN;		/* Race with shadow */
> +		goto out_free;
>  	}
>  	crst_table_init(s_r3t, _REGION3_ENTRY_EMPTY);
>  	/* mark as invalid as long as the parent table is not
> protected */

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

