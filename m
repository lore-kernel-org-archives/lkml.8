Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C6EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 13:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55012053B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 13:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LRb5LpcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHHNGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 09:06:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726125AbgHHNGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 09:06:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 078D15j3134717;
        Sat, 8 Aug 2020 09:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=U8X6qRYCXP4zF6uXjsokluM1K/PbdmKCnP7Vf5VhsAs=;
 b=LRb5LpcQUo/o33OEtF9v6XO3l9udI1cHs2ZTHPoVTm6+SA8kSve993zbSPL/kBaQvZoS
 vQ0fFfhUya21sLF2TYGJYAp8fCIwD+Zy/u+XmprYsa30E3GcWSZgc/Z4+zJi7SI0lwDz
 wvln1q79iEoTIrxWahghtO98oRGgdWVK+9IrMyVauy4sZv7cok48VgobR8DsdKA5tEe1
 xGmXY1PzJK/1sa+cK+TyVSg1xZx/XQMi99VVjrjdGYtDsRhvQOtSqcu0NozQIC2C9J54
 q/vCDT3h88963vj061nbYlKTDgkmZCC6j5uT9D5kk8sdJq9Icb5kAMoQPOYPAK8rFIyi 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32srbycpjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Aug 2020 09:06:05 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 078D1Cos135111;
        Sat, 8 Aug 2020 09:06:05 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32srbycpjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Aug 2020 09:06:05 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 078D4fP6023661;
        Sat, 8 Aug 2020 13:06:03 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 32skp88ct9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Aug 2020 13:06:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 078D5v3U30998942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Aug 2020 13:05:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9F2311C04A;
        Sat,  8 Aug 2020 13:05:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50E7011C054;
        Sat,  8 Aug 2020 13:05:57 +0000 (GMT)
Received: from localhost (unknown [9.145.77.129])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  8 Aug 2020 13:05:57 +0000 (GMT)
Date:   Sat, 8 Aug 2020 15:05:55 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux plumbers + clang + s390 virtualized testing
Message-ID: <your-ad-here.call-01596891955-ext-8436@work.hours>
References: <CAKwvOdn-2E=v_7Uie71pz2jjYCKnk98K1Ly8EkpxzvC6M5pXFA@mail.gmail.com>
 <20200716112840.GC8484@osiris>
 <your-ad-here.call-01596030682-ext-1369@work.hours>
 <CAKwvOd=1E+90VHwzh9cYGz9YKy_ECMJuK6gZhzLqBFw9kS4Cww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=1E+90VHwzh9cYGz9YKy_ECMJuK6gZhzLqBFw9kS4Cww@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-08_05:2020-08-06,2020-08-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008080092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 12:02:52PM -0700, Nick Desaulniers wrote:
> On Wed, Jul 29, 2020 at 6:51 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
> >
> > > > We were very excited to see your patches going by for enabling Clang
> > > > support for s390.  Since then, we've added s390 builds to our
> > > > continuous integration setup.
> > > >
> > > > We've been running into a few issues with doing virtualized boot tests
> > > > of our kernels on s390.
> > > >
> > > > I was curious if you'll both be attending Linux plumbers conf?  If we
> > > > carve out time for an s390+clang talk, would this be of interest to
> > > > you to attend?
> > I will attend and it would surely be interesting to me and other
> > s390 folks. Your efforts are greatly appreciated!
> 
> Cool, so our MC has been approved:
> https://www.linuxplumbersconf.org/event/7/page/80-accepted-microconferences#llvm-cr
> 
> But we're super tight on time and probably won't be able to do a
> session on s390 at the MC.  That said, I have just submitted a BoF
> proposal since we have more topics internal to our group we'd like to
> have more time to discuss.  I've added s390 testing to the list of
> potential topics, too.  I'll re-ping this thread once I hear back
> about whether it gets approved or not.
> 
> That said, we do meet once every other week virtually online, see
> links: https://clangbuiltlinux.github.io/.
> 
> >
> > BTW I believe basic Clang support for s390 came earlier in 5.2 with
> > a lot of efforts from Arnd Bergmann.
> >
> > My part was fixing recent breakages and bugging our s390 clang team
> > (which did all the great work) to get kernel specific features support
> > in clang 10 and 11 to reach features parity with gcc. And eventually
> > doing few adjustments so that features which came with clang 10 and
> > 11 are working smoothly. That is s390 "asm goto" support and specific
> > compiler flags for ftrace support and stack packing.
> 
> That's awesome; I'd love to get the chance to meet your s390 LLVM
> team; in general it can take a while to get bugs routed to folks most
> empowered to fix them until you know who they are.
> 
> Would you, any fellow s390 kernel and LLVM folks be interested in
> attending one of our virtual meetings, even if it's just to say "hi"
> quickly? Next one is next Wednesday.
> 
> Usually we go over whatever firedrills we've been running the past two
> weeks, but sometimes have presentations of folks projects and
> research.  I think it would be cool to get more background on s390 and
> work out the issues we're running into with testing.

I've added few more people in To. We'll try to make it next Wednesday,
but no promises since we are based in Germany and this is quite late
for us.
