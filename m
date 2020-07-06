Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C965C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D29F20708
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgGFQHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:07:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729293AbgGFQHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:07:13 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066G4EY5065090;
        Mon, 6 Jul 2020 12:06:46 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 322p98g4w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 12:06:46 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 066G6hmv025524;
        Mon, 6 Jul 2020 16:06:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 322h1h2f95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 16:06:43 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 066G6ffj64946650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jul 2020 16:06:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60F794C04A;
        Mon,  6 Jul 2020 16:06:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AD4F4C040;
        Mon,  6 Jul 2020 16:06:40 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.205.149])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Jul 2020 16:06:40 +0000 (GMT)
Date:   Mon, 6 Jul 2020 19:06:38 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Chris Mason <clm@fb.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200706160638.GG2999146@linux.ibm.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200705045505.GA2962@1wt.eu>
 <798B0FBF-D7A8-4631-8581-5D199DA50FF9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <798B0FBF-D7A8-4631-8581-5D199DA50FF9@fb.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_12:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007060118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Mon, Jul 06, 2020 at 12:45:34PM +0000, Chris Mason via Ksummit-discuss wrote:
> On 5 Jul 2020, at 0:55, Willy Tarreau wrote:
> 
> > On Sat, Jul 04, 2020 at 01:02:51PM -0700, Dan Williams wrote:
> >> +Non-inclusive terminology has that same distracting effect which is 
> >> why
> >> +it is a style issue for Linux, it injures developer efficiency.
> >
> > I'm personally thinking that for a non-native speaker it's already
> > difficult to find the best term to describe something, but having to
> > apply an extra level of filtering on the found words to figure whether
> > they are allowed by the language police is even more difficult.
> 
> Since our discussions are public, we’ve always had to deal with 
> comments from people outside the community on a range of topics.  But 
> inside the kernel, it’s just a group of developers trying to help each 
> other produce the best quality of code.  We’ve got a long history 
> together and in general I think we’re pretty good at assuming good 
> intent.

I don't think anybody doubts your intentions. But they say, the road to
hell is paved with good intentions.

I had a "privilege" to live in the USSR and back there Newspeak was not a
fiction but a reality. 

And despite the good intent, I have a really strong feeling that this
could be a step in a wrong direction...

> > *This*
> > injures developers efficiency. What could improve developers 
> > efficiency
> > is to take care of removing *all* idiomatic or cultural words then. 
> > For
> > example I've been participating to projects using the term 
> > "blueprint",
> > I didn't understand what that meant. It was once explained to me and
> > given that it had no logical reason for being called this way, I now
> > forgot. If we follow your reasoning, Such words should be banned for
> > exactly the same reasons. Same for colors that probably don't mean
> > anything to those born blind.
> >
> > For example if in my local culture we eat tomatoes at starters and
> > apples for dessert, it could be convenient for me to use "tomato" and
> > "apple" as list elements to name the pointers leading to the beginning
> > and the end of the list, and it might sound obvious to many people, 
> > but
> > not at all for many others.
> >
> > Maybe instead of providing an explicit list of a few words it should
> > simply say that terms that take their roots in the non-technical world
> > and whose meaning can only be understood based on history or local
> > culture ought to be avoided, because *that* actually is the real
> > root cause of the problem you're trying to address.
> 
> I’d definitely agree that it’s a good goal to keep out non-technical 
> terms.  Even though we already try, every subsystem has its own set of 
> patterns that reflect the most frequent contributors.
> 
> -chris
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

-- 
Sincerely yours,
Mike.
