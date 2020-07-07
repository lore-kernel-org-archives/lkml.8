Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A0AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D79207E8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgGGOrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:47:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1442 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726805AbgGGOrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:47:36 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067EkZcO062253;
        Tue, 7 Jul 2020 10:47:05 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324mcamrve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 10:47:05 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 067EaWja027432;
        Tue, 7 Jul 2020 14:47:02 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 322hd83kwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 14:47:02 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 067Ejj0g61472952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 14:45:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07247A4055;
        Tue,  7 Jul 2020 14:45:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CDB2A4057;
        Tue,  7 Jul 2020 14:45:44 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.169])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  7 Jul 2020 14:45:44 +0000 (GMT)
Date:   Tue, 7 Jul 2020 17:45:42 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Message-ID: <20200707144542.GD9411@linux.ibm.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
 <202007062234.A90F922DF@keescook>
 <DM6PR06MB3836FBAD65096AF63ACD3DB3EE660@DM6PR06MB3836.namprd06.prod.outlook.com>
 <202007070137.3ADBEDC@keescook>
 <20200707094147.213e0a82@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707094147.213e0a82@oasis.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_08:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=1 mlxlogscore=999 spamscore=0 impostorscore=0
 cotscore=-2147483648 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 09:41:47AM -0400, Steven Rostedt wrote:
> On Tue, 7 Jul 2020 01:54:23 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > "I will whitelist the syscall" -- sounds correct to me (same for
> > "it is whitelisted" or "it is in whitelisting mode").
> > 
> > "I will allow-list the syscall" -- sounds wrong to me (same for
> > "it is allow-listed" or "it is in allow-listing mode").
> 
> That's because we can't just make "allow-list" a drop in replacement
> for "whitelist" as I too (native English speaker) find it awkward. But
> then we don't need to make it a drop in replacement.
> 
> "I will whitelist the syscall" will become "I will add the syscall to
> the allow-list", which sounds perfectly fine, and even better than
> saying "I will add the syscall to the whitelist".

I will allow the syscall?

> -- Steve

-- 
Sincerely yours,
Mike.
