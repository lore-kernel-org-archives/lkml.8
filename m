Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD638C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DFE221E9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgDQJSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:18:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729987AbgDQJSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:18:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03H946rV145589
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:18:00 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30f4shyu2a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:18:00 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <vaibhav@linux.ibm.com>;
        Fri, 17 Apr 2020 10:17:53 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Apr 2020 10:17:50 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03H9HrLG58196110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 09:17:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59C8E4C046;
        Fri, 17 Apr 2020 09:17:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC59E4C040;
        Fri, 17 Apr 2020 09:17:49 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.79.187.50])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 17 Apr 2020 09:17:49 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Fri, 17 Apr 2020 14:47:48 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <ellerman@au1.ibm.com>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC] seq_buf: Export symbols to external modules
In-Reply-To: <20200416090951.6f74b0c8@gandalf.local.home>
References: <20200416035124.549067-1-vaibhav@linux.ibm.com> <20200416090951.6f74b0c8@gandalf.local.home>
Date:   Fri, 17 Apr 2020 14:47:48 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 20041709-0028-0000-0000-000003F9D03E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041709-0029-0000-0000-000024BF8966
Message-Id: <87eesmwjwj.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_03:2020-04-14,2020-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=728 adultscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for looking into this patch Steven,

Steven Rostedt <rostedt@goodmis.org> writes:

> On Thu, 16 Apr 2020 09:21:24 +0530
> Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
>> 'seq_buf' provides a very useful abstraction for writing to a string
>> buffer without needing to worry about it over-flowing. However even
>> though the API has been stable for couple of years now its stills not
>> exported to external modules limiting its usage.
>> 
>> Hence this patch proposes update to 'seq_buf.c' to mark all functions
>> seq_buf_X() which are part of the seq_seq API to be exported to
>> external GPL modules.
>> 
>> Earlier work:
>> There was an earlier proposal by Borislav Petkov <bp@alien8.de> to
>> export seq_buf_printf() to modules at [1], as part of his EDAC
>> patch-set "EDAC, mce_amd: Add a tracepoint for the decoded
>> error". However the proposed patch was never merged and its fate is
>> unknown as I couldn't locate any subsequent discussion as to why patch
>> in [1] was dropped.
>> 
>> References:
>> [1]: https://lore.kernel.org/lkml/20170825102411.8682-5-bp@alien8.de/
>> [2]: https://lore.kernel.org/lkml/20170825092757.434f1eda@gandalf.local.home/
>> 
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
>> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>>  lib/seq_buf.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>>
>
> I'm perfectly fine with this change, but recently there's been a lot of
> discussion about doing something like this for out-of-tree modules. Is
> there going to be a use case for in tree modules for this? It will make the
> case much easier to get this accepted.

Having these symbols exported to modules should simplify generating file
content for pseudo file systems like sysfs or procfs. Many of the in
kernel modules export atleast one such attribute file. Using seq_buf
api provides a safe way to populate the read buffers for these attrs
as these string buffers are PAGE_SIZE in length and a buggy module can
easily cause an overflow.

My specific use-case is exporting a set of nvdimm specific flags from
papr_scm kernel module [1] via sysfs through a patch proposed at [2] and
using seq_buf should considerably simply my code as suggested by Mpe
at [3].

[1] arch/powerpc/platforms/pseries/papr_scm.c
[2] https://lore.kernel.org/linux-nvdimm/20200331143229.306718-2-vaibhav@linux.ibm.com
[3] https://lore.kernel.org/linux-nvdimm/878sjetcis.fsf@mpe.ellerman.id.au

>
> -- Steve

-- 
Vaibhav

