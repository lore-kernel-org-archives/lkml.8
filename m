Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D348FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DACC20936
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="j+nnNdd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbgIHSGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:06:17 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:29358 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731516AbgIHQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:12:10 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088FSZJk027718;
        Tue, 8 Sep 2020 15:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=l/eZPcLoDELypWdnSeCo9QZ1du6a2GFgcoGfG4g/M9c=;
 b=j+nnNdd+JyqmfbdJsoQmdb48idBKHimounOB1lJQHjg1rqm1le0qV184b/bsv18mka9A
 bMNhum21Mx5pRJT5hGlLiVkbNYG0W1VsdY7mcuiWzdXYO+VjdQ5kj5VATuS/Imn/HlzH
 bVez+2LvjSEssdDxxhmzzPRuarkAiMzJcamGiu6hoth6ZsNnzMyaaZeKYkBRH8H83Ic9
 kvqdLj0xKuAa1nL6bVLUKSrALoLICOxi/h5whIi/tqMIaavhI+MlpTbvzoDsqIl+wK6s
 pm2R2ecbBQeTSWYdUtQHf5OmN6biqZjgq73HyLZkGnOLBO4YAGfDuWstAYuzUKn5ppYD 4w== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0a-002e3701.pphosted.com with ESMTP id 33c182s89q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 15:28:35 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 1E4AC86;
        Tue,  8 Sep 2020 15:28:19 +0000 (UTC)
Received: from [16.99.146.51] (unknown [16.99.146.51])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 94D0036;
        Tue,  8 Sep 2020 15:28:16 +0000 (UTC)
Subject: Re: [PATCH 00/12] x86/platform/uv: Updates for UV5
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20200907185430.363197758@hpe.com>
 <20200908152014.GB4114051@kroah.com>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <03de6a71-5fc1-98f5-3886-536c72b2761d@hpe.com>
Date:   Tue, 8 Sep 2020 08:28:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200908152014.GB4114051@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_08:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 spamscore=2 mlxscore=2
 mlxlogscore=170 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2020 8:20 AM, Greg KH wrote:
> On Mon, Sep 07, 2020 at 01:54:30PM -0500, Mike Travis wrote:
>> Subject: [PATCH 00/12] x86/platform/uv: Updates for UV5
>>
>> Add changes needed for new UV5 UV architecture.  Chief among the changes
>> are 52 bits of physical memory address and 57 bits of virtual address space.
>>
>> 0001 Remove UV BAU TLB Shootdown Handler
>>      - removes BAU TLB code being replaced by BAU APIC driver
>>
>> 0002 Remove SCIR built in driver
>>      - removes System Controller (monitoring) code
>>
>> 0003 Update UV kernel modules
>>      - update loadable UV kernel modules prior to a clash of symbols
>>        (is_uv) produced by auto-generated UV5 uv_mmrs.h file
>>
>> 0004 Update UV MMRs for UV5
>>      - update uv_mmrs.h file and fix resultant compiler errors
>>
>> 0005 Add UV5 direct references
>>      - add references to UV5 specific values
>>
>> 0006 Decode and Use Arch Type in UVsystab
>>      - add UV ArchType field to UVsystab to remove dependency on OEM_ID
>>
>> 0007 Update MMIOH references
>>      - display MMIOH mapping for each MMIOH region
>>
>> 0008 Adjust GAM MMR references
>>      - update GAM mapping for MMR accesses
>>
>> 0009 Update UV GRU references
>>      - update GRU mapping to include UV5
>>
>> 0010 Update Node Present Counting
>>      - UV5 changes method of counting nodes present
>>
>> 0011 Update UV5 TSC Checking
>>      - update TSC sync check of BIOS sync status
>>
>> 0012 Update for UV5 NMI MMR changes
>>      - update NMI handler
>>
> 
> No diffstat?  Did you use 'git format-patch' cover letter for this?

I didn't.  If I could figure out how to convert quilt patches into git 
commits I might be able to do that?  (And I didn't know that diffstats 
were needed on the into?)

Thanks,
Mike

> 
> thanks,
> 
> greg k-h
> 
