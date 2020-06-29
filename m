Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A105C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3312082F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404713AbgF2WFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:05:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbgF2SfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:19 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TBZdHO132225;
        Mon, 29 Jun 2020 07:56:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ydk8w3p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 07:56:32 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TBaD7B135261;
        Mon, 29 Jun 2020 07:56:32 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ydk8w3mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 07:56:32 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TBpvef012283;
        Mon, 29 Jun 2020 11:56:30 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 31wwch25f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 11:56:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TBt7MH63045990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 11:55:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25FDAAE04D;
        Mon, 29 Jun 2020 11:56:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7209AE055;
        Mon, 29 Jun 2020 11:56:24 +0000 (GMT)
Received: from [9.102.22.29] (unknown [9.102.22.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Jun 2020 11:56:24 +0000 (GMT)
Subject: Re: [PATCH 01/11] kexec_file: allow archs to handle special regions
 while locating memory hole
To:     Petr Tesarik <ptesarik@suse.cz>
Cc:     Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319828304.16351.6990340111766605842.stgit@hbathini.in.ibm.com>
 <20200629133933.0787f562@ezekiel.suse.cz>
From:   Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <7981ae61-26c6-000c-9ee4-382dab3eecab@linux.ibm.com>
Date:   Mon, 29 Jun 2020 17:26:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629133933.0787f562@ezekiel.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_11:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=859 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 cotscore=-2147483648
 impostorscore=0 spamscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 29/06/20 5:09 pm, Petr Tesarik wrote:
> Hi Hari,
> 
> is there any good reason to add two more functions with a very similar
> name to an existing function? AFAICS all you need is a way to call a
> PPC64-specific function from within kexec_add_buffer (PATCH 4/11), so
> you could add something like this:
> 
> int __weak arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
> {
> 	return 0;
> }
> 
> Call this function from kexec_add_buffer where appropriate and then
> override it for PPC64 (it roughly corresponds to your
> kexec_locate_mem_hole_ppc64() from PATCH 4/11).
> 
> FWIW it would make it easier for me to follow the resulting code.

Right, Petr.

I was trying out a few things before I ended up with what I sent here.
Bu yeah.. I did realize arch_kexec_locate_mem_hole() would have been better
after sending out v1. Will take care of that in v2.

Thanks
Hari
