Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96684C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D5924686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgA1Ibf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:31:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgA1Ibf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:31:35 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S8OUxC106145
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 03:31:33 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xrg633gju-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 03:31:33 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <svens@linux.ibm.com>;
        Tue, 28 Jan 2020 08:31:31 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Jan 2020 08:31:29 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00S8VSME45940884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 08:31:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 374BE42042;
        Tue, 28 Jan 2020 08:31:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 027014203F;
        Tue, 28 Jan 2020 08:31:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 28 Jan 2020 08:31:27 +0000 (GMT)
Date:   Tue, 28 Jan 2020 09:31:27 +0100
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Shuah Khan <shuahkhan@gmail.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] selftests/ftrace: fix glob selftest
References: <20200108074043.21580-1-svens@linux.ibm.com>
 <20200108091155.4af8a2c5@gandalf.local.home>
 <20200127132255.GA75877@tuxmaker.boeblingen.de.ibm.com>
 <CAKocOOM1zNgzY8_LE41HpiYLWNkoWQA7z-DC2ZL1sFHpbVxkkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKocOOM1zNgzY8_LE41HpiYLWNkoWQA7z-DC2ZL1sFHpbVxkkA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
x-cbid: 20012808-0028-0000-0000-000003D514CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012808-0029-0000-0000-000024995B62
Message-Id: <20200128083127.GB31706@tuxmaker.boeblingen.de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=973
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On Mon, Jan 27, 2020 at 07:49:17AM -0700, Shuah Khan wrote:
> On Mon, Jan 27, 2020 at 6:23 AM Sven Schnelle <svens@linux.ibm.com> wrote:
> >
> > Hi Steve,
> >
> > On Wed, Jan 08, 2020 at 09:11:55AM -0500, Steven Rostedt wrote:
> > >
> > > Shuah,
> > >
> > > Want to take this through your tree?
> > >
> > >  https://lore.kernel.org/r/20200108074043.21580-1-svens@linux.ibm.com
> > >
> > > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >
> > As Shuah didn't reply, can you push that through your tree?
> >
> 
> Hi Sven,
> 
> Did you run getmaintainers of this patch? You didn't send this to my
> email address listed in the get maintainers file and also didn't cc
> linux-kselftest.

My fault, sorry.

> I just happen to notice this now. Please resend with steve's
> Reviewed-by tag to the recipients suggested by get_maintainers.pl
> I will take this through ksleftest tree.

Ok, thanks.

Regards
Sven

