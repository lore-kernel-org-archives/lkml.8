Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A48C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E1220771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbgGVAxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 20:53:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726468AbgGVAxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:53:33 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06M0VdrU023222;
        Tue, 21 Jul 2020 20:52:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32e1wkfphv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 20:52:57 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06M0WM7V025442;
        Tue, 21 Jul 2020 20:52:56 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32e1wkfphm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 20:52:56 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06M0p2gV000691;
        Wed, 22 Jul 2020 00:52:56 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 32brq97rdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 00:52:56 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06M0qt7o35193214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 00:52:55 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB3E7112064;
        Wed, 22 Jul 2020 00:52:55 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B25BB112061;
        Wed, 22 Jul 2020 00:52:54 +0000 (GMT)
Received: from oc6034535106.ibm.com (unknown [9.65.219.47])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jul 2020 00:52:54 +0000 (GMT)
Subject: Re: [PATCH v4 5/7] powerpc/iommu: Move iommu_table cleaning routine
 to iommu_table_clean
To:     Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200716071658.467820-1-leobras.c@gmail.com>
 <20200716071658.467820-6-leobras.c@gmail.com>
 <51235292-a571-8792-c693-d0dc6faeb21c@ozlabs.ru>
 <0f4c2d84d0958e98e7ada53c25750fe548cadf0b.camel@gmail.com>
From:   Brian King <brking@linux.vnet.ibm.com>
Message-ID: <d6078fce-bb5f-f829-5de2-5bce3cee2bd5@linux.vnet.ibm.com>
Date:   Tue, 21 Jul 2020 19:52:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0f4c2d84d0958e98e7ada53c25750fe548cadf0b.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_15:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 suspectscore=25 bulkscore=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/20 5:13 PM, Leonardo Bras wrote:
> On Tue, 2020-07-21 at 14:59 +1000, Alexey Kardashevskiy wrote:
>>
>> On 16/07/2020 17:16, Leonardo Bras wrote:
>>> Move the part of iommu_table_free() that does struct iommu_table cleaning
>>> into iommu_table_clean, so we can invoke it separately.
>>>
>>> This new function is useful for cleaning struct iommu_table before
>>> initializing it again with a new DMA window, without having it freed and
>>> allocated again.
>>>
>>> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
>>> ---
>>>  arch/powerpc/kernel/iommu.c | 30 ++++++++++++++++++------------
>>>  1 file changed, 18 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>>> index 9704f3f76e63..c3242253a4e7 100644
>>> --- a/arch/powerpc/kernel/iommu.c
>>> +++ b/arch/powerpc/kernel/iommu.c
>>> @@ -735,21 +735,10 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid,
>>>  	return tbl;
>>>  }
>>>  
>>> -static void iommu_table_free(struct kref *kref)
>>> +static void iommu_table_clean(struct iommu_table *tbl)
>>
>> iommu_table_free() + iommu_init_table() + set_iommu_table_base() should
>> work too, why new helper?
> 
> iommu_table_free() also frees the tbl, which would need allocate it
> again (new address) and to fill it up again, unnecessarily. 
> I think it's a better approach to only change what is needed.
> 
>> There is also iommu_table_clear() which does a different thing so you
>> need a better name.
> 
> I agree.
> I had not noticed this other function before sending the patchset. What
> would be a better name though? __iommu_table_free()? 
> 
>> Second, iommu_table_free
>> use and it would be ok as we would only see this when hot-unplugging a
>> PE because we always kept the default window.
>> Btw you must be seeing these warnings now every time you create DDW with
>> these patches as at least the first page is reserved, do not you?
> 
> It does not print a warning.
> I noticed other warnings, but not this one from iommu_table_free():
> /* verify that table contains no entries */
> if (!bitmap_empty(tbl->it_ma
> p, tbl->it_size))
> 	pr_warn("%s: Unexpected TCEs\n", __func__);
> 
> Before that, iommu_table_release_pages(tbl) is supposed to clear the 
> bitmap, so this only tests for a tce that is created in this short period.
> 
>> Since we are replacing a table for a device which is still in the
>> system, we should not try messing with its DMA if it already has
>> mappings so the warning should become an error preventing DDW. It is
>> rather hard to trigger in practice but I could hack a driver to ask for
>> 32bit DMA mask first, map few pages and then ask for 64bit DMA mask, it
>> is not illegal, I think. So this needs a new helper - "bool
>> iommu_table_in_use(tbl)" - to use in enable_ddw(). Or I am overthinking
>> this?... Thanks,
> 
> As of today, there seems to be nothing like that happening in the
> driver I am testing. 
> I spoke to Brian King on slack, and he mentioned that at the point DDW
> is created there should be no allocations in place.

I think there are a couple of scenarios here. One is where there is a DMA
allocation prior to a call to set the DMA mask. Second scenario is if the
driver makes multiple calls to set the DMA mask. I would argue that a properly
written driver should tell the IOMMU subsystem what DMA mask it supports prior
to allocating DMA memroy. Documentation/core-api/dma-api-howto.rst should
describe what is legal and what is not.

It might be reasonable to declare its not allowed to allocate DMA memory
and then later change the DMA mask and clearly call this out in the documentation
if its not already.

-Brian


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

