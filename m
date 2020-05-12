Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56F3CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5254206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o3maW5cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgELT1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 15:27:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35878 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELT1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:27:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CJNHsN171902;
        Tue, 12 May 2020 19:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=B1ilk38pVJNHZxtzKrEaQQmfeMCogI5wZ4W4cxoKqao=;
 b=o3maW5csK70kotv7E5lIflQZ+u7EKprZxTRfg8ifZGlXpTy/igvyAEBbHyODj9DwVXim
 G98q0xFRZhF6JXOHIonEygmtt1KR29UnDN2zVXO3uYNrdNAMRdecK7aNu4lp/1KDtmQY
 XN64GfVpoGdAfL8Kye5L9kTUtAwYhcZK/FoCK4vSux55d/Cnk2D6zLhcyonWCkVItPOm
 QksOKWkWkTFA+5LxejbhmpxxxZhR4u8sXKiQMtaXE8JHlIT3LH3KIAyWxm9I3XzxUVms
 yh4Ge6vxCJR5x3YOXrLDFLT3ZjJP5i2dACy5JcMamyWQfRhirffy8z6w0IgD6plGWJH8 SA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3100xwgb40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 19:26:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CJIk6m130040;
        Tue, 12 May 2020 19:26:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3100ynesuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 19:26:50 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04CJQhbD018845;
        Tue, 12 May 2020 19:26:43 GMT
Received: from linux-1.home (/92.157.36.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 May 2020 12:26:42 -0700
Subject: Re: [RFC v4][PATCH part-1 0/7] ASI - Part I (ASI Infrastructure and
 PTI)
To:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com
References: <20200504144939.11318-1-alexandre.chartre@oracle.com>
 <a65d6cbf-41de-3001-6792-21a4233d8467@intel.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <bdfe70f7-2c61-092a-86d0-a7c71e6a3a8d@oracle.com>
Date:   Tue, 12 May 2020 21:25:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a65d6cbf-41de-3001-6792-21a4233d8467@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005120145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005120145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dave,

On 5/12/20 7:45 PM, Dave Hansen wrote:
> On 5/4/20 7:49 AM, Alexandre Chartre wrote:
>> This version 4 of the kernel Address Space Isolation (ASI) RFC. I have
>> broken it down into three distinct parts:
>>
>>   - Part I: ASI Infrastructure and PTI (this part)
>>   - Part II: Decorated Page-Table
>>   - Part III: ASI Test Driver and CLI
>>
>> Part I is similar to RFCv3 [3] with some small bug fixes. Parts II and III
>> extend the initial patchset: part II introduces decorated page-table in
>> order to provide convenient page-table management functions, and part III
>> provides a driver and CLI for testing ASI (using parts I and II).
> 
> These look interesting.  I haven't found any holes in your methods,
> although the interrupt depth tracking worries me a bit.  I tried and
> failed to do a similar thing with PTI in the NMI path, but you might
> have just bested me there. :)

Thanks for taking a look. I am glad it seems okay, I have run several tests
and was unable to have it fail (so far) while previous versions were easily
breakable.

> It's very interesting that you've been able to implement PTI underneath
> all of this, and the "test driver" is really entertaining!

Yeah, this a kind of PTI on steroid as part of the implementation was done
based on the PTI implementation but making it more generic. The test driver
has proven very useful for testing and debugging. I am currently using it
(with some extensions) for helping me define the KVM ASI: I can connect the
driver to a KVM ASI, dump the KVM ASI faults and dynamically add mappings;
this is very handy.

> That said, this is working in some of the nastiest corners of the x86
> code and this is going to take quite an investment to get reviewed.  I'm
> not *quite* sure it's all worth it.

I am also concerned about making changes in all these nasty corners. I am a
bit more confident now that it is working to implement PTI because PTI provides
a good stress test for ASI. I am also waiting for (and reviewing) all x86/entry
changes from tglx; this greatly cleans up the entry code and will hopefully help
for the integration of ASI. I will rebase as soon as these all changes are
integrated and check the benefit for ASI.

> So, this isn't being ignored, I'm just not quite sure what to do with
> it, yet.
> 

I am working on defining ASI for KVM. Hopefully this will provide a good
usage example, and make the changes more compelling.

Thanks.

alex.
