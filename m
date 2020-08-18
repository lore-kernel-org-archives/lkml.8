Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B499C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 081392076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FBhkqSYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgHRH2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:28:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726324AbgHRH2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:28:10 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07I71W11170622;
        Tue, 18 Aug 2020 03:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=Plz3faVHn1l7YMarpJrfZIwxrKYy8W6ZKpY/wJOckdA=;
 b=FBhkqSYhiab3P8Gs5Jl4Ej+vQ6hXprrn2zN/VVInDjlsEc2KOqDMtuBVVf0kSFnOLF7J
 UTml1Yg3CF1BSjdC/6Sl8gSgJ/fAYw8Qixmsl4xQqKFDXm/4zrZUg3v5X0YNqt18A0E3
 L0dNPxFit1IPvkpJtOxOXe9BFfEMcaLclrUtP8x8xY5NPSy9OR/EFhLPeYlHHCmzs4bG
 v2Lad7b16L/lKfIhZH8gtgs4HBFLcKTsCRzoQpkeif95Xs5woNuAk4O2C8m1IFoceOuQ
 +pRNwyNqvgneCEJXp6fXBPYlaWhPfhUxRIG+yz+4D1Rxxon/FCHXGB1tsH1L99z6FPRn gQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3304td7r4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 03:28:04 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07I7FDFV024124;
        Tue, 18 Aug 2020 07:28:02 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3304ujr6ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 07:28:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07I7RxPF19202426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 07:28:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBB6BA4064;
        Tue, 18 Aug 2020 07:27:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88EF9A4062;
        Tue, 18 Aug 2020 07:27:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Aug 2020 07:27:58 +0000 (GMT)
Subject: Re: [PATCH 1/2] proc: Add struct mount & struct super_block addr in
 lx-mounts command
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1597721575.git.riteshh@linux.ibm.com>
 <af4d266dd2d6b45403feca45395e3146a6f497cd.1597721575.git.riteshh@linux.ibm.com>
 <3babefe6-8784-dd9a-75ca-bb6ecff3106c@siemens.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 18 Aug 2020 12:57:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3babefe6-8784-dd9a-75ca-bb6ecff3106c@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200818072758.88EF9A4062@b06wcsmtp001.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_04:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=812 malwarescore=0 mlxscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/20 11:07 AM, Jan Kiszka wrote:
> On 18.08.20 06:04, Ritesh Harjani wrote:
>> This is many times found useful while debugging some FS related issue.
>>
>> <e.g. output>
>>        mount          super_block      fstype devname pathname options
>> 0xffff888a0bfa4b40 0xffff888a0bfc1000 rootfs none / rw   0 0
>> 0xffff888a02c065c0 0xffff8889fcf65000 ext4 /dev/root / rw  ,relatime 0 0
>> 0xffff8889fc8cc040 0xffff888a0bb51000 devtmpfs devtmpfs /dev rw  ,relatime 0 0
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>>   scripts/gdb/linux/proc.py | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
>> index 6a56bba233a9..c16fab981bdd 100644
>> --- a/scripts/gdb/linux/proc.py
>> +++ b/scripts/gdb/linux/proc.py
>> @@ -167,6 +167,9 @@ values of that process namespace"""
>>           if not namespace:
>>               raise gdb.GdbError("No namespace for current process")
>>   
>> +        gdb.write("{:^18} {:^15} {:>9} {} {} options\n".format(
>> +                  "mount", "super_block", "fstype", "devname", "pathname"))
>> +
>>           for vfs in lists.list_for_each_entry(namespace['list'],
>>                                                mount_ptr_type, "mnt_list"):
>>               devname = vfs['mnt_devname'].string()
>> @@ -190,14 +193,10 @@ values of that process namespace"""
>>               m_flags = int(vfs['mnt']['mnt_flags'])
>>               rd = "ro" if (s_flags & constants.LX_SB_RDONLY) else "rw"
>>   
>> -            gdb.write(
>> -                "{} {} {} {}{}{} 0 0\n"
>> -                .format(devname,
>> -                        pathname,
>> -                        fstype,
>> -                        rd,
>> -                        info_opts(FS_INFO, s_flags),
>> -                        info_opts(MNT_INFO, m_flags)))
>> +            gdb.write("{} {} {} {} {} {} {} {} 0 0\n".format(
>> +                      vfs.format_string(), superblock.format_string(), fstype,
>> +                      devname, pathname, rd, info_opts(FS_INFO, s_flags),
>> +                      info_opts(MNT_INFO, m_flags)))
> 
> The last three format elements should not be space-separated. The effect
> can even be seen in your example above.

yes, agreed. Will fix it in next version.

-ritesh
