Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDA0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47964207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgGTEbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:31:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725267AbgGTEbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:31:43 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06K43ORn185348;
        Mon, 20 Jul 2020 00:31:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32bt0sh8q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 00:31:05 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06K45dnM191005;
        Mon, 20 Jul 2020 00:31:04 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32bt0sh8pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 00:31:04 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06K4U1Ir011876;
        Mon, 20 Jul 2020 04:31:02 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 32brq810cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 04:31:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06K4Ux6a33620128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 04:31:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E17CFAE055;
        Mon, 20 Jul 2020 04:30:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72E48AE045;
        Mon, 20 Jul 2020 04:30:57 +0000 (GMT)
Received: from [9.199.36.102] (unknown [9.199.36.102])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jul 2020 04:30:57 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] powerpc/powernv/idle: save-restore DAWR0, DAWRX0
 for P10
To:     Nicholas Piggin <npiggin@gmail.com>,
        Pratik Rajesh Sampat <psampat@linux.ibm.com>
References: <20200710052207.12003-1-psampat@linux.ibm.com>
 <20200710052207.12003-3-psampat@linux.ibm.com>
 <1594619458.45vrahx59w.astroid@bobo.none>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, mpe@ellerman.id.au, paulus@samba.org,
        pratik.r.sampat@gmail.com, svaidy@linux.ibm.com
Message-ID: <ddf13184-86a3-5b84-6b4f-d901fc884ba5@linux.ibm.com>
Date:   Mon, 20 Jul 2020 10:00:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594619458.45vrahx59w.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-19_04:2020-07-17,2020-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxlogscore=834 spamscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 7/13/20 11:22 AM, Nicholas Piggin wrote:
> Excerpts from Pratik Rajesh Sampat's message of July 10, 2020 3:22 pm:
>> Additional registers DAWR0, DAWRX0 may be lost on Power 10 for
>> stop levels < 4.
>> Therefore save the values of these SPRs before entering a  "stop"
>> state and restore their values on wakeup.
> 
> Hmm, where do you get this from? Documentation I see says DAWR is lost
> on POWER9 but not P10.
> 
> Does idle thread even need to save DAWR, or does it get switched when
> going to a thread that has a watchpoint set?

I don't know how idle states works internally but IIUC, we need to save/restore
DAWRs. This is needed when user creates per-cpu watchpoint event.

Ravi
