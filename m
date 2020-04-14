Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC0BC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D6C2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440006AbgDNMS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:18:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439999AbgDNMSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:18:39 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03EC5bjv014829
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:18:38 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30b9hvasb7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:18:38 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Tue, 14 Apr 2020 13:18:09 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Apr 2020 13:18:08 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03ECIXAc53477610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 12:18:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B560AE04D;
        Tue, 14 Apr 2020 12:18:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08813AE053;
        Tue, 14 Apr 2020 12:18:32 +0000 (GMT)
Received: from [9.199.55.119] (unknown [9.199.55.119])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Apr 2020 12:18:31 +0000 (GMT)
Subject: Re: [PATCH v6 2/3] powerpc/powernv: Introduce support and parsing for
 self-save API
To:     ego@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, skiboot@lists.ozlabs.org, oohall@gmail.com,
        linuxram@us.ibm.com, pratik.r.sampat@gmail.com
References: <20200326071034.12838-1-psampat@linux.ibm.com>
 <20200326071034.12838-3-psampat@linux.ibm.com>
 <20200414074702.GF24277@in.ibm.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Date:   Tue, 14 Apr 2020 17:48:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414074702.GF24277@in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20041412-0008-0000-0000-000003708189
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041412-0009-0000-0000-00004A923005
Message-Id: <cd07bd96-31af-1908-0584-5f4a0cead5f1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_05:2020-04-14,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gautham,

[..snip..]

>> +
>> +			if (curr_spr.supported_mode & FIRMWARE_SELF_SAVE) {
>> +				rc = opal_slw_self_save_reg(pir,
>> +							curr_spr.spr);
>> +				if (rc != 0)
>> +					return rc;
>> +				switch (curr_spr.spr) {
>> +				case SPRN_LPCR:
>> +					is_lpcr_self_save = true;
> Could you consider converting is_lpcr_self_save and is_ptcr_self_save
> into static_keys ? For reference see commit
> 14c73bd344da("powerpc/vcpu: Assume dedicated processors as
> non-preempt")
>
Sure, using static keys is cleaner.

I'll also address the other nits mentioned in the e-mail earlier.

Thanks for the review.
Pratik

