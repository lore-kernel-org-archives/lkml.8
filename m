Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB6CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56922208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Psc9f2Hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbgE1KCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:02:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16022 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387518AbgE1KCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:02:01 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04S9XG2g125806;
        Thu, 28 May 2020 06:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=t3jmzpatn37yoENhNGM1lxSbA+A11PiqK0dyWwQyJ3U=;
 b=Psc9f2HjXxKkRjk64MUXwyTCHzPbupCyp89jU+eZ9kZ3ElcZ60u8TKYdnWJWQeLwtolp
 srht3XQZIFnH2IWC0MSGdbaTBtXQ2DWf25A/nzOD6oSMQ/plLZlW/hP5efbpklG4DZNR
 ZvhkvlnM7NCQGYrMyjsQ0isXmJhWbucWo+B3cbztVp3GYwDV0uodA7CwmpOHUwgX15oY
 09aNcf2Smbtlclrxx1XKPQ3eknzjfvcDVp+bhrVvcF3ARRAsY2GXbaCNUIj4PbK457a4
 VufyOJxEPbMnoRVbr0ix/MXsV+MJKYLkinJ6Dx59Jj9WdvPibnEoTlM0VyCeizwLHhms bQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 317hekq7mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 06:01:57 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04S9jXiE013116;
        Thu, 28 May 2020 10:01:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 316uf91ppx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 10:01:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04SA1kqV58851562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 10:01:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F35EB11C074;
        Thu, 28 May 2020 10:01:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9367B11C050;
        Thu, 28 May 2020 10:01:45 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.63.92])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 May 2020 10:01:45 +0000 (GMT)
Subject: Re: [PATCH 1/1] s390/pci: Log new handle in clp_disable_fh()
To:     Petr Tesarik <ptesarik@suse.com>, linux-s390@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20200522183922.5253-1-ptesarik@suse.com>
 <20200528110813.7eb1fc1f@ezekiel.suse.cz>
From:   Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <595c993e-0be4-3164-2498-b915c3fc9726@linux.ibm.com>
Date:   Thu, 28 May 2020 12:01:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200528110813.7eb1fc1f@ezekiel.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_02:2020-05-28,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=738 malwarescore=0 clxscore=1011 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005280064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020-05-28 11:08, Petr Tesarik wrote:
> Hi all,
> 
> just a gentle ping.
> 
> If the current behaviour (logging the original handle) was intended,
> then it was worth mentioning in the commit message for 17cdec960cf77,
> which made the change, but since that's no longer an option, I'd be
> happy with an explanation in email.
> 
> Petr T
> 
> On Fri, 22 May 2020 20:39:22 +0200
> Petr Tesarik <ptesarik@suse.com> wrote:
> 
>> After disabling a function, the original handle is logged instead of
>> the disabled handle.

Hi Petr,

Sorry for the delay, no doubt, you are right, the fh in zpci_dbg is the 
old one and we should use the one in the zdev struct.

Thanks,
Pierre

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>


>>
>> Fixes: 17cdec960cf77 (s390/pci: Recover handle in clp_set_pci_fn())
>> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
>> ---
>>   arch/s390/pci/pci_clp.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
>> index ea794ae755ae..179bcecefdee 100644
>> --- a/arch/s390/pci/pci_clp.c
>> +++ b/arch/s390/pci/pci_clp.c
>> @@ -309,14 +309,13 @@ int clp_enable_fh(struct zpci_dev *zdev, u8 nr_dma_as)
>>   
>>   int clp_disable_fh(struct zpci_dev *zdev)
>>   {
>> -	u32 fh = zdev->fh;
>>   	int rc;
>>   
>>   	if (!zdev_enabled(zdev))
>>   		return 0;
>>   
>>   	rc = clp_set_pci_fn(zdev, 0, CLP_SET_DISABLE_PCI_FN);
>> -	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, fh, rc);
>> +	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, zdev->fh, rc);
>>   	return rc;
>>   }
>>   
> 

-- 
Pierre Morel
IBM Lab Boeblingen
