Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4023DC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2EB206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mXJA48lR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgDTSWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:22:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47524 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgDTSWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:22:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03KIIJQf103953;
        Mon, 20 Apr 2020 18:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=YAe/kBwaj+k0OLqGn306HIwxykWUaCxSaVh68EcGBLk=;
 b=mXJA48lRXq26WJJdYhNHEb7zFKYYAEtVPRpqgANH1Y3WrRRdQpVzjWKRpsa+25dnmPdg
 g80cXpXxmQ5yhE7oI/JXE9HWYiQQVTCoJysn2n+zh3r5SpEzhKALBtQsZgRNY/ZM3t8t
 L+unDfSaejoddNBF1L7V8HAbLD5wYAB6tpXw0P+nYNpiupaem1FSqGKFbjhkSdxDEFM2
 awHdRvrnFkxG5daEOZXqv400ZjvBLiS/ODyl6Mi5DFvJOxZCrmxgH6xEL9oklC9EnO9i
 aiKaS2bOHq52YCvdguH09Qnvqws6z3my6IMrX1+eSpy7PW6k+zLTvFiG+FDEoHnMN+YM Pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30grpgdbnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 18:21:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03KIBWWP117177;
        Mon, 20 Apr 2020 18:21:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30gb3quxyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 18:21:51 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03KILoEC022169;
        Mon, 20 Apr 2020 18:21:50 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Apr 2020 11:21:50 -0700
Date:   Mon, 20 Apr 2020 14:22:11 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v4 07/10] mmap locking API: add
 mmap_read_trylock_non_owner()
Message-ID: <20200420182211.exrzkszefraeylv2@ca-dmjordan1.us.oracle.com>
References: <20200415004353.130248-1-walken@google.com>
 <20200415004353.130248-8-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415004353.130248-8-walken@google.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004200147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004200147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:43:50PM -0700, Michel Lespinasse wrote:
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 11d41f0c7005..998968659892 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -317,7 +316,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  	 * with build_id.
>  	 */
>  	if (!user || !current || !current->mm || irq_work_busy ||
> -	    mmap_read_trylock(current->mm) == 0) {
> +	    !mmap_read_trylock_non_owner(current->mm)) {
>  		/* cannot access current->mm, fall back to ips */
>  		for (i = 0; i < trace_nr; i++) {
>  			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
> @@ -342,16 +341,10 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  	}
>  
>  	if (!work) {
> -		mmap_read_unlock(current->mm);
> +		mmap_read_unlock_non_owner(current->mm);

These 'non_owner' calls are not intuitive because current _is the owner, so the
v3 version seems better, even if it adds a special wrapper for rwsem_release.

Though it makes some sense if you think, "we're consistently using the
non_owner APIs because there's a legitimate use somewhere else," so I'm fine
either way.

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
