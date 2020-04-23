Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988B8C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A6220767
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DCM3VBUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgDWPiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:38:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40922 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbgDWPiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:38:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NFJ0Ye152130;
        Thu, 23 Apr 2020 15:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Ke3uI4ILcmC+tdjd5OGvuVLJlepu5b3rI6oqe3FwIQw=;
 b=DCM3VBUEjvoj/7d203ua7PNnlbYPw4+0cWbj/CT/XvCFDj4PS1RYL6iEG9AZjkUvM5V7
 thOYDtQIVve00MEiKDqrhH6dvAKsNSIAZ6KFaRc3MuTbNDRnsH4v+K2b/5KqkCMoTE97
 mdWwjLZJJLXhOlMis1uXMBQF2qx7CvHgBH1w5cPZPkgpK/aOitTmhPURGsF/AHBHNOVF
 VznfHvyMEMROTFz7wyU4sv5+b7JYFIhMIRzXRl39X5+hATJhVf/JzhbCv8TCM1glVmDY
 jc4fT3vEDTlPZKgITVnJrTnD9M32svWUZbS/ZOlLxrjw+5/jqDSOclqt5Q3Ykh/7jCSY 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30k7qe22mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 15:37:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NFHhQV107398;
        Thu, 23 Apr 2020 15:35:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30gb3vsc2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 15:35:58 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03NFZucA022742;
        Thu, 23 Apr 2020 15:35:56 GMT
Received: from linux-1.home (/92.157.36.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Apr 2020 08:35:56 -0700
Subject: Re: [PATCH 3/8] objtool: Rework allocating stack_ops on decode
To:     Peter Zijlstra <peterz@infradead.org>, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz
References: <20200423125013.452964352@infradead.org>
 <20200423125042.713052240@infradead.org>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <7df9ec97-dc14-c4b6-fb26-f163e9afb1cd@oracle.com>
Date:   Thu, 23 Apr 2020 17:40:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423125042.713052240@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=2 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=2 mlxlogscore=999 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/23/20 2:47 PM, Peter Zijlstra wrote:
> Wrap each stack_op in a macro that allocates and adds it to the list.
> This simplifies trying to figure out what to do with the pre-allocated
> stack_op at the end.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   tools/objtool/arch/x86/decode.c |  257 +++++++++++++++++++++++-----------------
>   1 file changed, 153 insertions(+), 104 deletions(-)
> 
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -77,6 +77,17 @@ unsigned long arch_jump_destination(stru
>   	return insn->offset + insn->len + insn->immediate;
>   }
>   
> +#define PUSH_OP(op) \
> +({ \
> +	list_add_tail(&op->list, ops_list); \
> +	NULL; \
> +})
> +
> +#define ADD_OP(op) \
> +	if (!(op = calloc(1, sizeof(*op)))) \
> +		return -1; \
> +	else for (; op; op = PUSH_OP(op))
> +

I would better have a function to alloc+add op instead of weird macros,
for example:

static struct stack_op *add_op(void)
{
         struct stack *op;

         op = calloc(1, sizeof(*op));
         if (!op)
                 return NULL;
         list_add_tail(&op->list, ops_list);
}

Then it requires two more lines when using it but I think the code is much
cleaner and clearer, e.g.:

                         op = add_op();
                         if (!op)
                                 return -1;
                         op->src.type = OP_SRC_ADD;
                         op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
                         op->dest.type = OP_DEST_REG;
                         op->dest.reg = CFI_SP;

alex.

>   int arch_decode_instruction(struct elf *elf, struct section *sec,
>   			    unsigned long offset, unsigned int maxlen,
>   			    unsigned int *len, enum insn_type *type,
> @@ -88,7 +99,7 @@ int arch_decode_instruction(struct elf *
>   	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
>   		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
>   		      modrm_reg = 0, sib = 0;
> -	struct stack_op *op;
> +	struct stack_op *op = NULL;
>   
>   	x86_64 = is_x86_64(elf);
>   	if (x86_64 == -1)
> @@ -129,10 +140,6 @@ int arch_decode_instruction(struct elf *
>   	if (insn.sib.nbytes)
>   		sib = insn.sib.bytes[0];
>   
> -	op = calloc(1, sizeof(*op));
> -	if (!op)
> -		return -1;
> -
>   	switch (op1) {
>   
>   	case 0x1:
> @@ -141,10 +148,12 @@ int arch_decode_instruction(struct elf *
>   
>   			/* add/sub reg, %rsp */
>   			*type = INSN_STACK;
> -			op->src.type = OP_SRC_ADD;
> -			op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
> -			op->dest.type = OP_DEST_REG;
> -			op->dest.reg = CFI_SP;
> +			ADD_OP(op) {
> +				op->src.type = OP_SRC_ADD;
> +				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
> +				op->dest.type = OP_DEST_REG;
> +				op->dest.reg = CFI_SP;
> +			}
>   		}
>   		break;
>   
> @@ -152,9 +161,11 @@ int arch_decode_instruction(struct elf *
>   
>   		/* push reg */
>   		*type = INSN_STACK;
> -		op->src.type = OP_SRC_REG;
> -		op->src.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
> -		op->dest.type = OP_DEST_PUSH;
> +		ADD_OP(op) {
> +			op->src.type = OP_SRC_REG;
> +			op->src.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
> +			op->dest.type = OP_DEST_PUSH;
> +		}
>   
>   		break;
>   
> @@ -162,9 +173,11 @@ int arch_decode_instruction(struct elf *
>   
>   		/* pop reg */
>   		*type = INSN_STACK;
> -		op->src.type = OP_SRC_POP;
> -		op->dest.type = OP_DEST_REG;
> -		op->dest.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
> +		ADD_OP(op) {
> +			op->src.type = OP_SRC_POP;
> +			op->dest.type = OP_DEST_REG;
> +			op->dest.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
> +		}
>   
>   		break;
>   
> @@ -172,8 +185,10 @@ int arch_decode_instruction(struct elf *
>   	case 0x6a:
>   		/* push immediate */
>   		*type = INSN_STACK;
> -		op->src.type = OP_SRC_CONST;
> -		op->dest.type = OP_DEST_PUSH;
> +		ADD_OP(op) {
> +			op->src.type = OP_SRC_CONST;
> +			op->dest.type = OP_DEST_PUSH;
> +		}
>   		break;
>   
>   	case 0x70 ... 0x7f:
> @@ -188,11 +203,13 @@ int arch_decode_instruction(struct elf *
>   		if (modrm == 0xe4) {
>   			/* and imm, %rsp */
>   			*type = INSN_STACK;
> -			op->src.type = OP_SRC_AND;
> -			op->src.reg = CFI_SP;
> -			op->src.offset = insn.immediate.value;
> -			op->dest.type = OP_DEST_REG;
> -			op->dest.reg = CFI_SP;
> +			ADD_OP(op) {
> +				op->src.type = OP_SRC_AND;
> +				op->src.reg = CFI_SP;
> +				op->src.offset = insn.immediate.value;
> +				op->dest.type = OP_DEST_REG;
> +				op->dest.reg = CFI_SP;
> +			}
>   			break;
>   		}
>   
> @@ -205,11 +222,13 @@ int arch_decode_instruction(struct elf *
>   
>   		/* add/sub imm, %rsp */
>   		*type = INSN_STACK;
> -		op->src.type = OP_SRC_ADD;
> -		op->src.reg = CFI_SP;
> -		op->src.offset = insn.immediate.value * sign;
> -		op->dest.type = OP_DEST_REG;
> -		op->dest.reg = CFI_SP;
> +		ADD_OP(op) {
> +			op->src.type = OP_SRC_ADD;
> +			op->src.reg = CFI_SP;
> +			op->src.offset = insn.immediate.value * sign;
> +			op->dest.type = OP_DEST_REG;
> +			op->dest.reg = CFI_SP;
> +		}
>   		break;
>   
>   	case 0x89:
> @@ -217,10 +236,12 @@ int arch_decode_instruction(struct elf *
>   
>   			/* mov %rsp, reg */
>   			*type = INSN_STACK;
> -			op->src.type = OP_SRC_REG;
> -			op->src.reg = CFI_SP;
> -			op->dest.type = OP_DEST_REG;
> -			op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
> +			ADD_OP(op) {
> +				op->src.type = OP_SRC_REG;
> +				op->src.reg = CFI_SP;
> +				op->dest.type = OP_DEST_REG;
> +				op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
> +			}
>   			break;
>   		}
>   
> @@ -228,10 +249,12 @@ int arch_decode_instruction(struct elf *
>   
>   			/* mov reg, %rsp */
>   			*type = INSN_STACK;
> -			op->src.type = OP_SRC_REG;
> -			op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
> -			op->dest.type = OP_DEST_REG;
> -			op->dest.reg = CFI_SP;
> +			ADD_OP(op) {
> +				op->src.type = OP_SRC_REG;
> +				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
> +				op->dest.type = OP_DEST_REG;
> +				op->dest.reg = CFI_SP;
> +			}
>   			break;
>   		}
>   
> @@ -242,21 +265,25 @@ int arch_decode_instruction(struct elf *
>   
>   			/* mov reg, disp(%rbp) */
>   			*type = INSN_STACK;
> -			op->src.type = OP_SRC_REG;
> -			op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
> -			op->dest.type = OP_DEST_REG_INDIRECT;
> -			op->dest.reg = CFI_BP;
> -			op->dest.offset = insn.displacement.value;
> +			ADD_OP(op) {
> +				op->src.type = OP_SRC_REG;
> +				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
> +				op->dest.type = OP_DEST_REG_INDIRECT;
> +				op->dest.reg = CFI_BP;
> +				op->dest.offset = insn.displacement.value;
> +			}
>   
>   		} else if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
>   
>   			/* mov reg, disp(%rsp) */
>   			*type = INSN_STACK;
> -			op->src.type = OP_SRC_REG;
> -			op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
> -			op->dest.type = OP_DEST_REG_INDIRECT;
> -			op->dest.reg = CFI_SP;
> -			op->dest.offset = insn.displacement.value;
> +			ADD_OP(op) {
> +				op->src.type = OP_SRC_REG;
> +				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
> +				op->dest.type = OP_DEST_REG_INDIRECT;
> +				op->dest.reg = CFI_SP;
> +				op->dest.offset = insn.displacement.value;
> +			}
>   		}
>   
>   		break;
> @@ -266,22 +293,26 @@ int arch_decode_instruction(struct elf *
>   
>   			/* mov disp(%rbp), reg */
>   			*type = INSN_STACK;
> -			op->src.type = OP_SRC_REG_INDIRECT;
> -			op->src.reg = CFI_BP;
> -			op->src.offset = insn.displacement.value;
> -			op->dest.type = OP_DEST_REG;
> -			op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
> +			ADD_OP(op) {
> +				op->src.type = OP_SRC_REG_INDIRECT;
> +				op->src.reg = CFI_BP;
> +				op->src.offset = insn.displacement.value;
> +				op->dest.type = OP_DEST_REG;
> +				op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
> +			}
>   
>   		} else if (rex_w && !rex_b && sib == 0x24 &&
>   			   modrm_mod != 3 && modrm_rm == 4) {
>   
>   			/* mov disp(%rsp), reg */
>   			*type = INSN_STACK;
> -			op->src.type = OP_SRC_REG_INDIRECT;
> -			op->src.reg = CFI_SP;
> -			op->src.offset = insn.displacement.value;
> -			op->dest.type = OP_DEST_REG;
> -			op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
> +			ADD_OP(op) {
> +				op->src.type = OP_SRC_REG_INDIRECT;
> +				op->src.reg = CFI_SP;
> +				op->src.offset = insn.displacement.value;
> +				op->dest.type = OP_DEST_REG;
> +				op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
> +			}
>   		}
>   
>   		break;
> @@ -290,27 +321,31 @@ int arch_decode_instruction(struct elf *
>   		if (sib == 0x24 && rex_w && !rex_b && !rex_x) {
>   
>   			*type = INSN_STACK;
> -			if (!insn.displacement.value) {
> -				/* lea (%rsp), reg */
> -				op->src.type = OP_SRC_REG;
> -			} else {
> -				/* lea disp(%rsp), reg */
> -				op->src.type = OP_SRC_ADD;
> -				op->src.offset = insn.displacement.value;
> +			ADD_OP(op) {
> +				if (!insn.displacement.value) {
> +					/* lea (%rsp), reg */
> +					op->src.type = OP_SRC_REG;
> +				} else {
> +					/* lea disp(%rsp), reg */
> +					op->src.type = OP_SRC_ADD;
> +					op->src.offset = insn.displacement.value;
> +				}
> +				op->src.reg = CFI_SP;
> +				op->dest.type = OP_DEST_REG;
> +				op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
>   			}
> -			op->src.reg = CFI_SP;
> -			op->dest.type = OP_DEST_REG;
> -			op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
>   
>   		} else if (rex == 0x48 && modrm == 0x65) {
>   
>   			/* lea disp(%rbp), %rsp */
>   			*type = INSN_STACK;
> -			op->src.type = OP_SRC_ADD;
> -			op->src.reg = CFI_BP;
> -			op->src.offset = insn.displacement.value;
> -			op->dest.type = OP_DEST_REG;
> -			op->dest.reg = CFI_SP;
> +			ADD_OP(op) {
> +				op->src.type = OP_SRC_ADD;
> +				op->src.reg = CFI_BP;
> +				op->src.offset = insn.displacement.value;
> +				op->dest.type = OP_DEST_REG;
> +				op->dest.reg = CFI_SP;
> +			}
>   
>   		} else if (rex == 0x49 && modrm == 0x62 &&
>   			   insn.displacement.value == -8) {
> @@ -322,11 +357,13 @@ int arch_decode_instruction(struct elf *
>   			 * stack realignment.
>   			 */
>   			*type = INSN_STACK;
> -			op->src.type = OP_SRC_ADD;
> -			op->src.reg = CFI_R10;
> -			op->src.offset = -8;
> -			op->dest.type = OP_DEST_REG;
> -			op->dest.reg = CFI_SP;
> +			ADD_OP(op) {
> +				op->src.type = OP_SRC_ADD;
> +				op->src.reg = CFI_R10;
> +				op->src.offset = -8;
> +				op->dest.type = OP_DEST_REG;
> +				op->dest.reg = CFI_SP;
> +			}
>   
>   		} else if (rex == 0x49 && modrm == 0x65 &&
>   			   insn.displacement.value == -16) {
> @@ -338,11 +375,13 @@ int arch_decode_instruction(struct elf *
>   			 * stack realignment.
>   			 */
>   			*type = INSN_STACK;
> -			op->src.type = OP_SRC_ADD;
> -			op->src.reg = CFI_R13;
> -			op->src.offset = -16;
> -			op->dest.type = OP_DEST_REG;
> -			op->dest.reg = CFI_SP;
> +			ADD_OP(op) {
> +				op->src.type = OP_SRC_ADD;
> +				op->src.reg = CFI_R13;
> +				op->src.offset = -16;
> +				op->dest.type = OP_DEST_REG;
> +				op->dest.reg = CFI_SP;
> +			}
>   		}
>   
>   		break;
> @@ -350,8 +389,10 @@ int arch_decode_instruction(struct elf *
>   	case 0x8f:
>   		/* pop to mem */
>   		*type = INSN_STACK;
> -		op->src.type = OP_SRC_POP;
> -		op->dest.type = OP_DEST_MEM;
> +		ADD_OP(op) {
> +			op->src.type = OP_SRC_POP;
> +			op->dest.type = OP_DEST_MEM;
> +		}
>   		break;
>   
>   	case 0x90:
> @@ -361,15 +402,19 @@ int arch_decode_instruction(struct elf *
>   	case 0x9c:
>   		/* pushf */
>   		*type = INSN_STACK;
> -		op->src.type = OP_SRC_CONST;
> -		op->dest.type = OP_DEST_PUSHF;
> +		ADD_OP(op) {
> +			op->src.type = OP_SRC_CONST;
> +			op->dest.type = OP_DEST_PUSHF;
> +		}
>   		break;
>   
>   	case 0x9d:
>   		/* popf */
>   		*type = INSN_STACK;
> -		op->src.type = OP_SRC_POPF;
> -		op->dest.type = OP_DEST_MEM;
> +		ADD_OP(op) {
> +			op->src.type = OP_SRC_POPF;
> +			op->dest.type = OP_DEST_MEM;
> +		}
>   		break;
>   
>   	case 0x0f:
> @@ -405,15 +450,19 @@ int arch_decode_instruction(struct elf *
>   
>   			/* push fs/gs */
>   			*type = INSN_STACK;
> -			op->src.type = OP_SRC_CONST;
> -			op->dest.type = OP_DEST_PUSH;
> +			ADD_OP(op) {
> +				op->src.type = OP_SRC_CONST;
> +				op->dest.type = OP_DEST_PUSH;
> +			}
>   
>   		} else if (op2 == 0xa1 || op2 == 0xa9) {
>   
>   			/* pop fs/gs */
>   			*type = INSN_STACK;
> -			op->src.type = OP_SRC_POP;
> -			op->dest.type = OP_DEST_MEM;
> +			ADD_OP(op) {
> +				op->src.type = OP_SRC_POP;
> +				op->dest.type = OP_DEST_MEM;
> +			}
>   		}
>   
>   		break;
> @@ -427,7 +476,8 @@ int arch_decode_instruction(struct elf *
>   		 * pop bp
>   		 */
>   		*type = INSN_STACK;
> -		op->dest.type = OP_DEST_LEAVE;
> +		ADD_OP(op)
> +			op->dest.type = OP_DEST_LEAVE;
>   
>   		break;
>   
> @@ -449,12 +499,14 @@ int arch_decode_instruction(struct elf *
>   	case 0xcf: /* iret */
>   		*type = INSN_EXCEPTION_RETURN;
>   
> -		/* add $40, %rsp */
> -		op->src.type = OP_SRC_ADD;
> -		op->src.reg = CFI_SP;
> -		op->src.offset = 5*8;
> -		op->dest.type = OP_DEST_REG;
> -		op->dest.reg = CFI_SP;
> +		ADD_OP(op) {
> +			/* add $40, %rsp */
> +			op->src.type = OP_SRC_ADD;
> +			op->src.reg = CFI_SP;
> +			op->src.offset = 5*8;
> +			op->dest.type = OP_DEST_REG;
> +			op->dest.reg = CFI_SP;
> +		}
>   		break;
>   
>   	case 0xca: /* retf */
> @@ -492,8 +544,10 @@ int arch_decode_instruction(struct elf *
>   
>   			/* push from mem */
>   			*type = INSN_STACK;
> -			op->src.type = OP_SRC_CONST;
> -			op->dest.type = OP_DEST_PUSH;
> +			ADD_OP(op) {
> +				op->src.type = OP_SRC_CONST;
> +				op->dest.type = OP_DEST_PUSH;
> +			}
>   		}
>   
>   		break;
> @@ -504,11 +558,6 @@ int arch_decode_instruction(struct elf *
>   
>   	*immediate = insn.immediate.nbytes ? insn.immediate.value : 0;
>   
> -	if (*type == INSN_STACK || *type == INSN_EXCEPTION_RETURN)
> -		list_add_tail(&op->list, ops_list);
> -	else
> -		free(op);
> -
>   	return 0;
>   }
>   
> 
> 
