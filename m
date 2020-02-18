Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC47C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC11F206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgBRJiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:38:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgBRJiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:38:01 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01I9U71s009003
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 04:37:59 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e2f7sc5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 04:37:59 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <prudo@linux.ibm.com>;
        Tue, 18 Feb 2020 09:37:57 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Feb 2020 09:37:55 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01I9bsV044105920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 09:37:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74C8411C04C;
        Tue, 18 Feb 2020 09:37:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37C8011C05B;
        Tue, 18 Feb 2020 09:37:54 +0000 (GMT)
Received: from laptop2-ibm.local (unknown [9.152.212.60])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Feb 2020 09:37:54 +0000 (GMT)
Date:   Tue, 18 Feb 2020 10:37:52 +0100
From:   Philipp Rudo <prudo@linux.ibm.com>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: s390 depending on cc-options makes it difficult to configure
In-Reply-To: <20200216185759.GA4091960@dev.jcline.org>
References: <20191209164155.GA78160@dev.jcline.org>
        <20191210090108.GA22512@unicorn.suse.cz>
        <20191211171822.GA36366@dev.jcline.org>
        <20200210194936.511ef603@laptop2-ibm.local>
        <CAK7LNATL3Oyn=FLKm0TcB9SkJLuCOWV06a_t-FRtFiFp9Vda1g@mail.gmail.com>
        <20200214203536.GA133402@laptop.jcline.org>
        <CAK7LNAQ9+n8eRyUVrqTNDu915VcE+uHQoewH8WzJqpOpi8rT0Q@mail.gmail.com>
        <20200216185759.GA4091960@dev.jcline.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021809-0012-0000-0000-00000387E519
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021809-0013-0000-0000-000021C474A4
Message-Id: <20200218103752.6d4b9167@laptop2-ibm.local>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_02:2020-02-17,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,


On Sun, 16 Feb 2020 13:57:59 -0500
Jeremy Cline <jcline@redhat.com> wrote:

> On Sun, Feb 16, 2020 at 01:08:49PM +0900, Masahiro Yamada wrote:
> > On Sat, Feb 15, 2020 at 5:35 AM Jeremy Cline <jcline@redhat.com> wrote:  
> > >
> > > On Fri, Feb 14, 2020 at 12:31:05PM +0900, Masahiro Yamada wrote:  
> > > > Hi.
> > > >
> > > > On Tue, Feb 11, 2020 at 3:49 AM Philipp Rudo <prudo@linux.ibm.com> wrote:  

[...]

> > > > One idea to workaround this is
> > > > to use a fake script that accepts any flag,
> > > > and use it as $(CC) in Kconfig.
> > > >
> > > > RFC patch is attached.
> > > >
> > > > This is not a perfect solution, of course.

I like the approach as it gives both sides what they need without blowing up
Kconfig.

> > > The attached patch doesn't looks like it'd work for what we need,  
> > 
> > I thought turning all cc-options to y would work
> > for what you need.
> > 
> > With this, you can enable
> > CONFIG_MARCH_Z13=y and CONFIG_TUNE_Z14=y
> > instead of CONFIG_TUNE_DEFAULT.
> > 
> > If this approach does not work for you,
> > what is your requirement?
> >   
> 
> Oof, this was an awful typo. It *would* work for what we need. Sorry for
> the confusion :(.
> 
> > 
> >   
> > > although I wonder if it's easier to just check when cc-options is
> > > defined for an environment variable or something and always return y
> > > instead of calling out to $(CC) at all. Comes to the same thing, I
> > > suppose.  
> > 
> > 
> > The macro definition in scripts/Kconfig.include
> > takes precedence over any environment variable.
> > 
> > So, if you want to hack it from the environment,
> > you need to change the code somehow.
> > 
> > The scripts/dummy-tools/ approach does not change
> > anything for the use-case in upstream.
> > 
> > The result is the same, of course.
> >   
> 
> Indeed. Since I'm not maintaining it I don't have a particularly strong
> opinion about the approach. Whatever you like most works for me.

I agree with Jeremy. Just pick what you think is best.

Thanks a lot
Philipp

