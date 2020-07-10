Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978A9C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E542207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgGJNpN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:45:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20362 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728260AbgGJNpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:45:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06AD2jma124518;
        Fri, 10 Jul 2020 09:44:57 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpsd2yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 09:44:57 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06ADYktp029804;
        Fri, 10 Jul 2020 13:44:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 326bc90auh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 13:44:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06ADiroA63308182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 13:44:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17B18A405C;
        Fri, 10 Jul 2020 13:44:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2F2BA4054;
        Fri, 10 Jul 2020 13:44:52 +0000 (GMT)
Received: from localhost (unknown [9.102.22.220])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jul 2020 13:44:52 +0000 (GMT)
Date:   Fri, 10 Jul 2020 19:14:47 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: kprobes
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     anil.s.keshavamurthy@intel.com, corbet@lwn.net,
        davem@davemloft.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>
References: <20200707194959.52487-1-grandmaster@al2klimov.de>
        <20200708184201.611d929ae6017c87ea98b114@kernel.org>
In-Reply-To: <20200708184201.611d929ae6017c87ea98b114@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Message-Id: <1594388442.4mjtjyic5z.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_07:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> On Tue,  7 Jul 2020 21:49:59 +0200
> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> 
>> Rationale:
>> Reduces attack surface on kernel devs opening the links for MITM
>> as HTTPS traffic is much harder to manipulate.
>> 
>> Deterministic algorithm:
>> For each file:
>>   If not .svg:
>>     For each line:
>>       If doesn't contain `\bxmlns\b`:
>>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>>           If both the HTTP and HTTPS versions
>>           return 200 OK and serve the same content:
>>             Replace HTTP with HTTPS.
> 
> OK, but it seems that some of them are disappeared :(
> 
>  http://www-106.ibm.com/developerworks/library/l-kprobes.html?ca=dgr-lnxw42Kprobe
> 
>  -> https://www.ibm.com/developerworks/library/l-kprobes/index.html

That looks right.

> 
>  http://www.redhat.com/magazine/005mar05/features/kprobes/
> 
>  -> I can not find that.

Ditto, we should drop that.

> 
>>  - http://www-users.cs.umn.edu/~boutcher/kprobes/
>>  - http://www.linuxsymposium.org/2006/linuxsymposium_procv2.pdf (pages 101-115)
> 
> Both are not found.

It looks like the first link is gone, but there seems to be a copy in 
the web archive:
https://web.archive.org/web/20061106154519/http://www-users.cs.umn.edu/~boutcher/kprobes/

I suppose we can drop that link.

> 
> (OT, it seems http://www.linuxsymposium.org/ has been left from historical
>  Linux Symposium, we must remove it asap)

Indeed, I think that link pointed to the Kprobes paper:
https://www.kernel.org/doc/ols/2006/ols2006v2-pages-109-124.pdf


- Naveen

