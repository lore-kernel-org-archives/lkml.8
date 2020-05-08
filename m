Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9509C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2BFC20A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEHKzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:55:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbgEHKzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:55:24 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048AVrEj129164;
        Fri, 8 May 2020 06:54:54 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsggm8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 06:54:54 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048AohPf023916;
        Fri, 8 May 2020 10:54:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5w8wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 10:54:51 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 048Asnn157737450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 10:54:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17D6FA4054;
        Fri,  8 May 2020 10:54:49 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 563C5A405C;
        Fri,  8 May 2020 10:54:46 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.93.12])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  8 May 2020 10:54:46 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Fri, 08 May 2020 16:24:45 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <ellerman@au1.ibm.com>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC] seq_buf: Export symbols to external modules
In-Reply-To: <20200420152043.1cd0a2ae@gandalf.local.home>
References: <20200416035124.549067-1-vaibhav@linux.ibm.com> <20200416090951.6f74b0c8@gandalf.local.home> <87eesmwjwj.fsf@vajain21.in.ibm.com> <20200420152043.1cd0a2ae@gandalf.local.home>
Date:   Fri, 08 May 2020 16:24:45 +0530
Message-ID: <87eeru8znu.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_08:2020-05-07,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=668
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Fri, 17 Apr 2020 14:47:48 +0530
> Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
>> Having these symbols exported to modules should simplify generating file
>> content for pseudo file systems like sysfs or procfs. Many of the in
>> kernel modules export atleast one such attribute file. Using seq_buf
>> api provides a safe way to populate the read buffers for these attrs
>> as these string buffers are PAGE_SIZE in length and a buggy module can
>> easily cause an overflow.
>> 
>> My specific use-case is exporting a set of nvdimm specific flags from
>> papr_scm kernel module [1] via sysfs through a patch proposed at [2] and
>> using seq_buf should considerably simply my code as suggested by Mpe
>> at [3].
>> 
>> [1] arch/powerpc/platforms/pseries/papr_scm.c
>> [2] https://lore.kernel.org/linux-nvdimm/20200331143229.306718-2-vaibhav@linux.ibm.com
>> [3] https://lore.kernel.org/linux-nvdimm/878sjetcis.fsf@mpe.ellerman.id.au
>
> This patch should be added to a patch series that needs it. Then I'll give
> my ack to it. That way, there's a reason to export them.
Thanks Steve,

I have posted a patch series at 
https://lore.kernel.org/linux-nvdimm/20200508104922.72565-1-vaibhav@linux.ibm.com/
titled "powerpc/papr_scm: Add support for reporting nvdimm health" that
contains a patch to export seq_buf_printf() viz patch
https://lore.kernel.org/linux-nvdimm/20200508104922.72565-3-vaibhav@linux.ibm.com/
titled "seq_buf: Export seq_buf_printf() to external modules"

~ Vaibhav
>
> -- Steve
