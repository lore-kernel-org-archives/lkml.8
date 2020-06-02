Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AF7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE3720734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgFBH0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:26:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725616AbgFBH0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 03:26:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05271m0J109860;
        Tue, 2 Jun 2020 03:26:28 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31dfsfcbuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 03:26:28 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0527Q6Tk004162;
        Tue, 2 Jun 2020 07:26:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 31bf47wj47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 07:26:26 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0527QN1g64422064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 07:26:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD7C752050;
        Tue,  2 Jun 2020 07:26:23 +0000 (GMT)
Received: from oc5500677777.ibm.com (unknown [9.145.186.47])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 733F85204E;
        Tue,  2 Jun 2020 07:26:23 +0000 (GMT)
Subject: Re: [PATCH 1/1] s390/pci: Log new handle in clp_disable_fh()
To:     Petr Tesarik <ptesarik@suse.com>, linux-s390@vger.kernel.org,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20200522183922.5253-1-ptesarik@suse.com>
 <20200528110813.7eb1fc1f@ezekiel.suse.cz>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <9e4a0dec-d249-9443-6b93-83e3f9f33674@linux.ibm.com>
Date:   Tue, 2 Jun 2020 09:26:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528110813.7eb1fc1f@ezekiel.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_05:2020-06-01,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 cotscore=-2147483648 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 mlxlogscore=801 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

sorry for not reacting sooner, I was on holiday, saw your message but figured it wasn't super critical.
Thanks for finding this issue and thank you Pierre and Vasily for stepping in.

Best,
Niklas Schnelle

On 5/28/20 11:08 AM, Petr Tesarik wrote:
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
>>
>> Fixes: 17cdec960cf77 (s390/pci: Recover handle in clp_set_pci_fn())
>> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
>> ---
>>  arch/s390/pci/pci_clp.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
>> index ea794ae755ae..179bcecefdee 100644
>> --- a/arch/s390/pci/pci_clp.c
>> +++ b/arch/s390/pci/pci_clp.c
>> @@ -309,14 +309,13 @@ int clp_enable_fh(struct zpci_dev *zdev, u8 nr_dma_as)
>>  
>>  int clp_disable_fh(struct zpci_dev *zdev)
>>  {
>> -	u32 fh = zdev->fh;
>>  	int rc;
>>  
>>  	if (!zdev_enabled(zdev))
>>  		return 0;
>>  
>>  	rc = clp_set_pci_fn(zdev, 0, CLP_SET_DISABLE_PCI_FN);
>> -	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, fh, rc);
>> +	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, zdev->fh, rc);
>>  	return rc;
>>  }
>>  
> 
