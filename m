Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B715CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E82A206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CdP8xB7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgFDWZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 18:25:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38726 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgFDWZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 18:25:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054MMYSC014139;
        Thu, 4 Jun 2020 22:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=QIucGuM946wGuAqT2ahSlsrPEDOzQqB1jJy/RDJjM5I=;
 b=CdP8xB7nOL3tpNEDBQLFUqyzORe7uWHf4TjPow0TL221nvGiFS+zuT90pcmPTPntkp4R
 5t+T5x0VzjUzlKD7pgaqD73QXH2O8s+h7Cm8pSzxgWaPCoUPockBZUU4jygtcU+DqfeK
 tjA8XFFH/miEPlzfa/+9kq6xEpTirac7OaJEiGHS1Ad9eZLMatgFvoRgXPvOkTfEpAbw
 Y1ICc0Fnbks7Czo66jSJTAA2SxXNj1xREH9zIwD2KF1kPYrM/0tDogA5Nn/t34rHlaGo
 7m/3xaMke0YsH8i8XA1/Phh2cyP02HtYc4YzD/XEMtnFmHMIX6rpSuguY/7wWG5aMyOB 4A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31f91dr4f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 22:24:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054MO5MJ172543;
        Thu, 4 Jun 2020 22:24:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31f926965g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 22:24:41 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 054MOYKV025770;
        Thu, 4 Jun 2020 22:24:39 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jun 2020 15:24:31 -0700
Date:   Thu, 4 Jun 2020 18:24:57 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH] x86/mm: use max memory block size with unaligned memory
 end
Message-ID: <20200604222457.wmyjtrbzbq4m45ng@ca-dmjordan1.us.oracle.com>
References: <20200604035443.3267046-1-daniel.m.jordan@oracle.com>
 <5827baaf-0eb5-bcea-5d98-727485683512@redhat.com>
 <20200604172213.f5lufktpqvqjkv4u@ca-dmjordan1.us.oracle.com>
 <ebc31650-9e98-f286-6fc2-aafdd3cd9272@redhat.com>
 <20200604181201.lqop72ihg5butlmz@ca-dmjordan1.us.oracle.com>
 <34d7b03c-4f32-05c3-b5ce-521951f518e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34d7b03c-4f32-05c3-b5ce-521951f518e8@redhat.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 cotscore=-2147483648 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006040155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 08:55:19PM +0200, David Hildenbrand wrote:
> >> E.g., on powerpc that's 16MB so they have *a lot* of memory blocks.
> >> That's why that's not papering over the problem. Increasing the memory
> >> block size isn't always the answer.
> > 
> > Ok.  If you don't mind, what's the purpose of hotplugging at that granularity?
> > I'm simply curious.
> 
> On bare metal: none with that big machines AFAIKS. :)

Sounds about right :)

> For VMs/partitions it gives you much more flexibility ("cloud", kata
> containers, memory overcommit, ...).
> 
> Assume you have a VM with some initial memory size (e.g., 32GB). By
> hotplugging up to 256 DIMMs you cab grow in small steps (e.g., 128MB, up
> to 64GB, 256MB, up to 96GB, ...). And if you online all the memory
> blocks MOVABLE, you can shrink in these small steps.

Yeah, sorry for not being clear, I meant why does powerpc hotplug at "only" 16M.

> Regarding PowerPC, AFAIK it also gives the OS more flexibility to find
> memory blocks that can be offlined and unplugged, especially without the
> MOVABLE zone. Finding some scattered 16MB blocks that can be offlined is
> easier than finding one bigger (e.g., 2GB) memory block that can be
> offlined. And the history of powerpc dlpar dates back to pre-MOVABLE
> days (there is a paper from 2003).

Makes sense, thanks!

> I do think your change mostly affects bare metal where you do not care
> about hotplugging small memory blocks. Maybe an even better check would be
> 
> if (!in_vm() {
> 	bz = MAX_BLOCK_SIZE;
> 	goto none;
> }
> 
> because I doubt we have bare metal machines > 64 where we want to
> hot(un)plug DIMMs < 2G.

Yeah, agreed, not these days.

> But maybe there is a use case I am not aware of
> ... and I don't know an easy way to check whether we are running inside
> a VM or not (like kvm_para_available() ... ).

What about this?  Works on bare metal and kvm, so presumably all the other HVs
too.

 if (x86_hyper_type == X86_HYPER_NATIVE) {
	bz = MAX_BLOCK_SIZE;
	goto done;
 }
