Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A692BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8461320812
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgFIGml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 02:42:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbgFIGmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:42:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0596VgAf025432;
        Tue, 9 Jun 2020 02:42:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31hys6qy1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 02:42:04 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0596VnnL025968;
        Tue, 9 Jun 2020 02:42:03 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31hys6qy10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 02:42:03 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0596aGra023961;
        Tue, 9 Jun 2020 06:42:01 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 31g2s7t68k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 06:42:01 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0596fwsm37093540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 06:41:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3E8DA4054;
        Tue,  9 Jun 2020 06:41:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DCC3A4060;
        Tue,  9 Jun 2020 06:41:57 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.199.50.138])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  9 Jun 2020 06:41:56 +0000 (GMT)
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v4 27/32] objtool: mcount: Generic location and
 relocation table types
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
 <311ccd169cec877d0c1993772818f0e5cdf11dc4.1591125127.git.mhelsley@vmware.com>
Message-ID: <79552506-b994-63ce-d3d9-8053dcbc02db@linux.vnet.ibm.com>
Date:   Tue, 9 Jun 2020 12:11:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <311ccd169cec877d0c1993772818f0e5cdf11dc4.1591125127.git.mhelsley@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_01:2020-06-08,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 cotscore=-2147483648 bulkscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/20 1:20 AM, Matt Helsley wrote:
> Rather than building the exact ELF section data we need and
> avoiding libelf's conversion step, use more GElf types
> and then libelf's elfxx_xlatetof() functions to convert
> the mcount locations (GElf_Addr) and associated relocations.
> 
> This converts sift_rel_mcount() so that it doesn't use the
> recordmcount wrapper. The next patch will move it out of the
> wrapper.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> ---
>  tools/objtool/recordmcount.c |  44 +++----------
>  tools/objtool/recordmcount.h | 120 ++++++++++++++---------------------
>  2 files changed, 59 insertions(+), 105 deletions(-)
> 
> diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
> index 06a8f8ddefa7..ef3c360a3db9 100644
> --- a/tools/objtool/recordmcount.c
> +++ b/tools/objtool/recordmcount.c

[...]

> -static uint_t *sift_rel_mcount(uint_t *mlocp,
> -			       unsigned const offbase,
> -			       Elf_Rel **const mrelpp,
> +static void sift_rel_mcount(GElf_Addr **mlocpp,
> +			       GElf_Sxword *r_offsetp,
> +			       void **const mrelpp,
>  			       const struct section * const rels,
>  			       unsigned const recsym_index,
>  			       unsigned long const recval,
> -			       unsigned const reltype)
> +			       unsigned const reltype,
> +			       bool is_rela)
>  {
> -	uint_t *const mloc0 = mlocp;
> -	Elf_Rel *mrelp = *mrelpp;
> -	unsigned int rel_entsize = rels->sh.sh_entsize;
> -	unsigned mcountsym = 0;
> +	GElf_Rel *mrelp = *mrelpp;
> +	GElf_Rela *mrelap = *mrelpp;
> +	unsigned int mcount_sym_info = 0;
>  	struct reloc *reloc;
> 
>  	list_for_each_entry(reloc, &rels->reloc_list, list) {
> -		if (!mcountsym)
> -			mcountsym = get_mcountsym(reloc);
> -
> -		if (mcountsym == GELF_R_INFO(reloc->sym->idx, reloc->type) && !is_fake_mcount(reloc)) {
> -			uint_t const addend =
> -				_w(reloc->offset - recval + mcount_adjust);
> -			mrelp->r_offset = _w(offbase
> -				+ ((void *)mlocp - (void *)mloc0));
> -			Elf_r_info(mrelp, recsym_index, reltype);
> -			if (rel_entsize == sizeof(Elf_Rela)) {
> -				((Elf_Rela *)mrelp)->r_addend = addend;
> -				*mlocp++ = 0;
> -			} else
> -				*mlocp++ = addend;
> -
> -			mrelp = (Elf_Rel *)(rel_entsize + (void *)mrelp);
> +		unsigned long addend;
> +
> +		if (!mcount_sym_info)
> +			mcount_sym_info = get_mcount_sym_info(reloc);
> +
> +		if (mcount_sym_info != GELF_R_INFO(reloc->sym->idx, reloc->type) || is_fake_mcount(reloc))
> +			continue;

Hi Matt,

I was trying out the patch series on ppc64le and found that __mcount_loc
and .rela__mcount_loc section pairs do not get generated. 

# readelf -S fs/proc/cmdline.o|grep mcount
#

Debugged the cause to get_mcountsym()'s return type.  It returns reloc
type from GELF_R_INFO() and expects Elf64_Xword a.k.a unsigned long
to be the return type but get_mcountsym() returns unsigned int on 64-bit.

On power the _mcount is of relocation type R_PPC64_REL24 (info 0x170000000a),
using unsigned int truncates the value to 0xa and fails the above check.
Using below fix, that converts mcount_sym_info to use unsigned long, generates
the __mcount_loc section pairs.

--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -163,7 +163,7 @@ static int is_mcounted_section_name(char const *const txtname)
                strcmp(".cpuidle.text", txtname) == 0;
 }
 
-static unsigned int get_mcount_sym_info(struct reloc *reloc)
+static unsigned long get_mcount_sym_info(struct reloc *reloc)
 {
        struct symbol *sym = reloc->sym;
        char const *symname = sym->name;
@@ -274,7 +274,7 @@ static int nop_mcount(struct section * const rels,
 {
        struct reloc *reloc;
        struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
-       unsigned int mcount_sym_info = 0;
+       unsigned long mcount_sym_info = 0;
        int once = 0;
 
        list_for_each_entry(reloc, &rels->reloc_list, list) {
@@ -363,7 +363,7 @@ static void sift_rel_mcount(GElf_Addr **mlocpp,
 {
        GElf_Rel *mrelp = *mrelpp;
        GElf_Rela *mrelap = *mrelpp;
-       unsigned int mcount_sym_info = 0;
+       unsigned long mcount_sym_info = 0;
        struct reloc *reloc;
 
        list_for_each_entry(reloc, &rels->reloc_list, list) {

# readelf -S fs/proc/cmdline.o|grep mcount
  [31] __mcount_loc      PROGBITS         0000000000000000  00022f10
  [32] .rela__mcount_loc RELA             0000000000000000  00022f20


> +
> +		addend = reloc->offset - recval + mcount_adjust;
> +		if (is_rela) {
> +			mrelap->r_offset = *r_offsetp;
> +			mrelap->r_info = GELF_R_INFO(recsym_index, reltype);
> +			mrelap->r_addend = addend;
> +			mrelap++;
> +			**mlocpp = 0;
> +		} else {
> +			mrelp->r_offset = *r_offsetp;
> +			mrelp->r_info = GELF_R_INFO(recsym_index, reltype);
> +			mrelp++;
> +			**mlocpp = addend;
>  		}
> +		(*mlocpp)++;
> +		r_offsetp += loc_size;

the offsets generated for rela__mcount_loc section are incorrect:

# readelf -rW fs/proc/meminfo.o
[...]
Relocation section '.rela__mcount_loc' at offset 0x59a48 contains 4 entries:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000000  0000000200000026 R_PPC64_ADDR64         0000000000000000 .text + c
00000a059c401f38  0000000200000026 R_PPC64_ADDR64         0000000000000000 .text + 64
0000000000000000  0000000200000026 R_PPC64_ADDR64         0000000000000000 .text + 7c
0000000000000000  0000000600000026 R_PPC64_ADDR64         0000000000000000 .init.text + c

changing the above line to *r_offsetp += loc_size and initializing
r_offset=0 in do_mcount() generates the correct offset:

# readelf -rW fs/proc/meminfo.o
[...]
Relocation section '.rela__mcount_loc' at offset 0x59a48 contains 4 entries:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000000  0000000200000026 R_PPC64_ADDR64         0000000000000000 .text + c
0000000000000008  0000000200000026 R_PPC64_ADDR64         0000000000000000 .text + 64
0000000000000010  0000000200000026 R_PPC64_ADDR64         0000000000000000 .text + 7c
0000000000000018  0000000600000026 R_PPC64_ADDR64         0000000000000000 .init.text + c

>  	}
> -	*mrelpp = mrelp;
> -	return mlocp;
> +	*mrelpp = is_rela ? (void *)mrelap : (void *)mrelp;
>  }
> 
> 
-- 
Kamalesh
