Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA73C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E14C20820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgEJM57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 08:57:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726863AbgEJM56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:57:58 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04ACUjtJ061216;
        Sun, 10 May 2020 08:57:08 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30xe5sbhur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 08:57:08 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04ACpD9g007705;
        Sun, 10 May 2020 12:57:06 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 30wm55afgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 12:57:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04ACv4sV63242508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 12:57:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58368AE04D;
        Sun, 10 May 2020 12:57:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19C48AE051;
        Sun, 10 May 2020 12:57:01 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.51.177])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Sun, 10 May 2020 12:57:00 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Sun, 10 May 2020 18:27:00 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Joe Perches <joe@perches.com>, Borislav Petkov <bp@alien8.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v7 2/5] seq_buf: Export seq_buf_printf() to external modules
In-Reply-To: <ff1fcc5b32a9ad209660c7cfe7e212c1a16ba10d.camel@perches.com>
References: <20200508104922.72565-1-vaibhav@linux.ibm.com> <20200508104922.72565-3-vaibhav@linux.ibm.com> <20200508113100.GA19436@zn.tnic> <87blmy8wm8.fsf@linux.ibm.com> <ff1fcc5b32a9ad209660c7cfe7e212c1a16ba10d.camel@perches.com>
Date:   Sun, 10 May 2020 18:27:00 +0530
Message-ID: <87y2q06j8j.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_04:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=1 priorityscore=1501 mlxscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxlogscore=786
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005100113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Joe Perches <joe@perches.com> writes:

> On Fri, 2020-05-08 at 17:30 +0530, Vaibhav Jain wrote:
>> Hi Boris,
>> 
>> Borislav Petkov <bp@alien8.de> writes:
>> 
>> > On Fri, May 08, 2020 at 04:19:19PM +0530, Vaibhav Jain wrote:
>> > > 'seq_buf' provides a very useful abstraction for writing to a string
>> > > buffer without needing to worry about it over-flowing. However even
>> > > though the API has been stable for couple of years now its stills not
>> > > exported to external modules limiting its usage.
>> > > 
>> > > Hence this patch proposes update to 'seq_buf.c' to mark
>> > > seq_buf_printf() which is part of the seq_buf API to be exported to
>> > > external GPL modules. This symbol will be used in later parts of this
>> > 
>> > What is "external GPL modules"?
>> I am referring to Kernel Loadable Modules with MODULE_LICENSE("GPL")
>> here.
>
> Any reason why these Kernel Loadable Modules with MODULE_LICENSE("GPL")
> are not in the kernel tree?

The Kernel GPL module that this patch reffers to is 'papr_scm' which is already
in kernel tree at arch/powerpc/platforms/pseries/papr_scm.c . 

~ Vaibhav
