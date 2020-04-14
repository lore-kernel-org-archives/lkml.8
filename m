Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A48C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC69A20644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ujNnnr01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438434AbgDNKfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:35:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56026 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438372AbgDNKcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:32:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAS66L099192;
        Tue, 14 Apr 2020 10:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=3elyCtL31IJdXHdlLwwE8jV/D1Z9hDRkcmsvbBLWNv4=;
 b=ujNnnr01CBKYRUAg/k9d/55h/0T+92MRQ9gYHyM4VkbaqDTC0HiBvxkOoCQSSrSswVtG
 6uTX6ppjVQmCZYLkkWIr1b2324Pq1y/myTau6Ul0LuJir8mXyGJMqdXBCTKJFie/fNmR
 +AXbvp7P1da3sxj5YrboYXQewcoNs0Q+VpJ118o+uK/Zbpmhx3kLs9ZZD8Ugi0OxWt2e
 C090vB7aHJsP7yd4vIlNFOyTFouQegPpH74T1WcKy8QJ1MQnyb7/MxEs3boZZPKmVXjl
 5gS93s3qobvCSiVmiKwJs5uBsPCylruJiWK/y0tKhuY0g9HKWxudpHICvnTaOjO3GRDI FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30b5um3nkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:32:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAR7CR034962;
        Tue, 14 Apr 2020 10:32:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30cta9txta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:32:01 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03EAW0DP008874;
        Tue, 14 Apr 2020 10:32:00 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 03:32:00 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V3 6/9] objtool: Report inconsistent stack changes in alternative
Date:   Tue, 14 Apr 2020 12:36:15 +0200
Message-Id: <20200414103618.12657-7-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200414103618.12657-1-alexandre.chartre@oracle.com>
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=1 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow a valid stack unwinding, an alternative should have code
where the same stack changes happens at the same places as in the
original code. Add a check in objtool to validate that stack changes
in alternative are effectively consitent with the original code.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c | 155 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0574ce8e232d..9488a9c7be24 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2724,6 +2724,156 @@ static int validate_reachable_instructions(struct objtool_file *file)
 	return 0;
 }
 
+static int validate_alternative_state(struct objtool_file *file,
+				      struct instruction *first,
+				      struct instruction *prev,
+				      struct instruction *current,
+				      bool include_current)
+{
+	struct instruction *alt_insn, *alt_first;
+	unsigned long roff_prev, roff_curr, roff;
+	int count, err = 0, err_alt, alt_num;
+	struct alternative *alt;
+	const char *err_str;
+
+	/*
+	 * Check that instructions in alternatives between the corresponding
+	 * previous and current instructions, have the same stack state.
+	 */
+
+	/* use relative offset to find corresponding alt instructions */
+	roff_prev = prev->offset - first->offset;
+	roff_curr = current->offset - first->offset;
+	alt_num = 0;
+
+	list_for_each_entry(alt, &first->alts, list) {
+		if (!alt->insn->alt_group)
+			continue;
+
+		alt_num++;
+		alt_first = alt->insn;
+		count = 0;
+		err_alt = 0;
+
+		for (alt_insn = alt_first;
+		     alt_insn && alt_insn->alt_group == alt_first->alt_group;
+		     alt_insn = next_insn_same_sec(file, alt_insn)) {
+
+			roff = alt_insn->offset - alt_first->offset;
+			if (roff < roff_prev)
+				continue;
+
+			if (roff > roff_curr ||
+			    (roff == roff_curr && !include_current))
+				break;
+
+			count++;
+			/*
+			 * The first instruction we check must be aligned with
+			 * the corresponding "prev" instruction because stack
+			 * change should happen at the same offset.
+			 */
+			if (count == 1 && roff != roff_prev) {
+				err_str = "misaligned alternative state change";
+				err_alt++;
+			}
+
+			if (!err_alt && memcmp(&prev->state, &alt_insn->state,
+					       sizeof(struct insn_state))) {
+				err_str = "invalid alternative state";
+				err_alt++;
+			}
+
+			/*
+			 * On error, report the error and stop checking
+			 * this alternative but continue checking other
+			 * alternatives.
+			 */
+			if (err_alt) {
+				if (!err) {
+					WARN_FUNC("error in alternative",
+						  first->sec, first->offset);
+				}
+				WARN_FUNC("in alternative %d",
+					  alt_first->sec, alt_first->offset,
+					  alt_num);
+				WARN_FUNC("%s", alt_insn->sec, alt_insn->offset,
+					  err_str);
+
+				err += err_alt;
+				break;
+			}
+		}
+	}
+
+	return err;
+}
+
+static int validate_alternative(struct objtool_file *file)
+{
+	struct instruction *first, *prev, *next, *insn;
+	bool in_alternative;
+	int err;
+
+	err = 0;
+	first = prev = NULL;
+	in_alternative = false;
+	for_each_insn(file, insn) {
+		if (insn->ignore || !insn->alt_group || insn->ignore_alts)
+			continue;
+
+		if (!in_alternative) {
+			if (list_empty(&insn->alts))
+				continue;
+
+			/*
+			 * Setup variables to start the processing of a
+			 * new alternative.
+			 */
+			first = insn;
+			prev = insn;
+			err = 0;
+			in_alternative = true;
+
+		} else if (!err && memcmp(&prev->state, &insn->state,
+					  sizeof(struct insn_state))) {
+			/*
+			 * The stack state has changed and no error was
+			 * reported for this alternative. Check that the
+			 * stack state is the same in all alternatives
+			 * between the last check and up to this instruction.
+			 *
+			 * Once we have an error, stop checking the
+			 * alternative because once the stack state is
+			 * inconsistent, it will likely be inconsistent
+			 * for other instructions as well.
+			 */
+			err = validate_alternative_state(file, first,
+							 prev, insn, false);
+			prev = insn;
+		}
+
+		/*
+		 * If the next instruction is in the same alternative then
+		 * continue with processing this alternative. Otherwise
+		 * that's the end of this alternative so check there is no
+		 * stack state changes in remaining instructions (if no
+		 * error was reported yet).
+		 */
+		next = list_next_entry(insn, list);
+		if (next && !next->ignore &&
+		    next->alt_group == first->alt_group)
+			continue;
+
+		if (!err)
+			err = validate_alternative_state(file, first,
+							 prev, insn, true);
+		in_alternative = false;
+	}
+
+	return 0;
+}
+
 static struct objtool_file file;
 
 int check(const char *_objname, bool orc)
@@ -2769,6 +2919,11 @@ int check(const char *_objname, bool orc)
 		goto out;
 	warnings += ret;
 
+	ret = validate_alternative(&file);
+	if (ret < 0)
+		goto out;
+	warnings += ret;
+
 	if (!warnings) {
 		ret = validate_reachable_instructions(&file);
 		if (ret < 0)
-- 
2.18.2

