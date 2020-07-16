Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A94C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 22:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56EB2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 22:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgGPWDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 18:03:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbgGPWDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 18:03:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GM2Wtq059669;
        Thu, 16 Jul 2020 18:03:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32a45by6mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 18:03:17 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06GM3H0N062253;
        Thu, 16 Jul 2020 18:03:17 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32a45by6mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 18:03:17 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06GLjTAM023747;
        Thu, 16 Jul 2020 22:03:15 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 3275294272-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 22:03:15 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06GM3CuA31851182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 22:03:12 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79F82C6062;
        Thu, 16 Jul 2020 22:03:14 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DAC1C606C;
        Thu, 16 Jul 2020 22:03:11 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.8.110])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Jul 2020 22:03:10 +0000 (GMT)
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com> <159466091925.24747.6840028682768745598.stgit@hbathini.in.ibm.com> <87365s9ysj.fsf@morokweng.localdomain> <baa29ea9-7698-a7e8-e5a4-c9f842e1fcc8@linux.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Pingfan Liu <piliu@redhat.com>, Nayna Jain <nayna@linux.ibm.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 06/12] ppc64/kexec_file: restrict memory usage of kdump kernel
In-reply-to: <baa29ea9-7698-a7e8-e5a4-c9f842e1fcc8@linux.ibm.com>
Date:   Thu, 16 Jul 2020 19:03:08 -0300
Message-ID: <875zance3n.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_11:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 phishscore=0
 spamscore=100 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxscore=100 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=-1000 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007160142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hari Bathini <hbathini@linux.ibm.com> writes:

> On 16/07/20 4:22 am, Thiago Jung Bauermann wrote:
>> 
>> Hari Bathini <hbathini@linux.ibm.com> writes:
>> 
>
> <snip>
>
>>> +/**
>>> + * get_node_path - Get the full path of the given node.
>>> + * @dn:            Node.
>>> + * @path:          Updated with the full path of the node.
>>> + *
>>> + * Returns nothing.
>>> + */
>>> +static void get_node_path(struct device_node *dn, char *path)
>>> +{
>>> +	if (!dn)
>>> +		return;
>>> +
>>> +	get_node_path(dn->parent, path);
>> 
>> Is it ok to do recursion in the kernel? In this case I believe it's not
>> problematic since the maximum call depth will be the maximum depth of a
>> device tree node which shouldn't be too much. Also, there are no local
>> variables in this function. But I thought it was worth mentioning.
>
> You are right. We are better off avoiding the recursion here. Will
> change it to an iterative version instead.

Ok.

>>> +	 * each representing a memory range.
>>> +	 */
>>> +	ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
>>> +
>>> +	for (i = 0; i < ranges; i++) {
>>> +		base = of_read_number(prop, n_mem_addr_cells);
>>> +		prop += n_mem_addr_cells;
>>> +		end = base + of_read_number(prop, n_mem_size_cells) - 1;
>
> prop is not used after the above.
>
>> You need to `prop += n_mem_size_cells` here.
>
> But yeah, adding it would make it look complete in some sense..

Isn't it used in the next iteration of the loop?

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
