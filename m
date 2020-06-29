Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1187EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC77A2065D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgF2SoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:44:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58154 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728053AbgF2Snz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:43:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05T5WiRG147333;
        Mon, 29 Jun 2020 01:55:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31x20gnhs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 01:55:11 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05T5oYa8004436;
        Mon, 29 Jun 2020 01:55:11 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31x20gnhre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 01:55:10 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05T5oNoe025934;
        Mon, 29 Jun 2020 05:55:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 31wyyas0wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 05:55:08 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05T5t6hY29098208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 05:55:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 148CAA404D;
        Mon, 29 Jun 2020 05:55:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 246A1A4040;
        Mon, 29 Jun 2020 05:55:03 +0000 (GMT)
Received: from [9.102.0.109] (unknown [9.102.0.109])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Jun 2020 05:55:02 +0000 (GMT)
Subject: Re: [PATCH 04/11] ppc64/kexec_file: avoid stomping memory used by
 special regions
To:     piliu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kexec-ml <kexec@lists.infradead.org>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319831192.16351.17443438699302756548.stgit@hbathini.in.ibm.com>
 <9cfda789-0747-a67a-b825-5ea6f15099b8@redhat.com>
From:   Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <f745de42-297e-6eed-d25b-ea21d6000dc5@linux.ibm.com>
Date:   Mon, 29 Jun 2020 11:25:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9cfda789-0747-a67a-b825-5ea6f15099b8@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_04:2020-06-26,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 cotscore=-2147483648 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006290039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/06/20 7:44 am, piliu wrote:
> Hi Hari,

Hi Pingfan,

> 
> After a quick through for this series, I have a few question/comment on
> this patch for the time being. Pls see comment inline.
> 
> On 06/27/2020 03:05 AM, Hari Bathini wrote:
>> crashkernel region could have an overlap with special memory regions
>> like  opal, rtas, tce-table & such. These regions are referred to as
>> exclude memory ranges. Setup this ranges during image probe in order
>> to avoid them while finding the buffer for different kdump segments.

[...]

>> +	/*
>> +	 * Use the locate_mem_hole logic in kexec_add_buffer() for regular
>> +	 * kexec_file_load syscall
>> +	 */
>> +	if (kbuf->image->type != KEXEC_TYPE_CRASH)
>> +		return 0;
> Can the ranges overlap [crashk_res.start, crashk_res.end]?  Otherwise
> there is no requirement for @exclude_ranges.

The ranges like rtas, opal are loaded by f/w. They almost always overlap with
crashkernel region. So, @exclude_ranges is required to support kdump.

> I guess you have a design for future. If not true, then it is better to
> fold the condition "if (kbuf->image->type != KEXEC_TYPE_CRASH)" into the
> caller and rename this function to better distinguish use cases between
> kexec and kdump

Yeah, this condition will be folded. I have a follow-up patch for that explaining
why kexec case should also be folded. Will try to add that to this series for v2.

Thanks
Hari
