Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD01C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC2620722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZScHoZf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgCWRhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:37:07 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:53101 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgCWRhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:37:07 -0400
Received: by mail-qk1-f202.google.com with SMTP id w124so13098055qkd.19
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/Zmo3bJ1xnFXe3gBJdx1K9tQ8YxPb1egchdBHFnw3y0=;
        b=ZScHoZf1uaQ/mboFT1TttcaIeu3+fNOid2hKM58Yx75UeKY4HKiHLzR4NFxwy1oCRX
         ae566tjGtvinpJcN2Kr6RVSjjJbRvwaHHW7DWYY2AsYO+GeK1rhsCXNPH32y82f1pOQo
         v9A6OeSn83FbRyjf4N2ioPT40sP2SwZYHxhRB1dqwv68khqvCcnlM17En/ksn314c2uV
         J84tACIntkO4Mffu3G84xOMjLgO1CnjGmdKIdGxNXr/VeKPFd+f+snkn0d1JxsbrH6oz
         bcQfdvGYCgCfW5dQcBZ+UOOdawS5fjXGduoYiVoL7VMYxCBGN/Hx10n74i5dHP1iNvl7
         YYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/Zmo3bJ1xnFXe3gBJdx1K9tQ8YxPb1egchdBHFnw3y0=;
        b=LNyiizWj7mu4UBpldV8jIcXVj2hfBn2XqG25WsucDHb9amTsnamF0Q8IyrLCgJTHMe
         ded+2lWxWdt9y8NlAW984Vqpgs6i1fB4oPG9rmaj1U/mB7Q8CjSMaRltFAHsVywNwO9I
         1Vq1MUZiBCrXExOhCkUQfiWRhG1SsyCyRsEbsmbPiRdZjIHThvKCxjAmPHdH+YKksdAP
         v2fsQ9jW4CcsswxMaWKM22aSVLmhI3IClIZpHpNOdZuZJKwnLF2aMLPhz2T8wObiYBUl
         JnTSn1KRe6DgdajndTzLfmtkOHfhsf+yjgg8K4Se9YdXHNn4SROYY53R3PH7rZPJ+Vuj
         2yKQ==
X-Gm-Message-State: ANhLgQ1DnGDroaB82HvNzsneGiRn3syk9UPULKHfAqIp4foTF4gZIN+R
        JVjQ4vpEoM+x9+1uzw3LBRbh6qryubDEMEeuG7A15Q==
X-Google-Smtp-Source: ADFU+vt/Nq2hgQpRn9XxiQaB9Am3Vuo6oDf66JgWBcrgQaW91mgN/l5QnylOzJtpli3SyPANctiEW9idVAmfKkHffm02bQ==
X-Received: by 2002:ac8:7769:: with SMTP id h9mr3509567qtu.234.1584985025152;
 Mon, 23 Mar 2020 10:37:05 -0700 (PDT)
Date:   Mon, 23 Mar 2020 10:36:53 -0700
Message-Id: <20200323173653.41305-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v1] kunit: tool: add missing test data file content
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, heidifahim@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test data file for one of the kunit_tool unit tests was missing; add
it in so that unit tests can run properly.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
Shuah, this is a fix for a broken test. Can you apply this for 5.7?
---
 .../testing/kunit/test_data/test_pound_sign.log  | Bin 0 -> 1656 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tools/testing/kunit/test_data/test_pound_sign.log b/tools/testing/kunit/test_data/test_pound_sign.log
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..28ffa5ba03bfa81ea02ea9d38e7de7acf3dd9e5d 100644
GIT binary patch
literal 1656
zcmah}U2EGg6n$=g#f7|Vtj^>lPBOzDM#o@mlt9+Kgd${FPEBlGBgsqs?{^h<Y3h$o
zFBaGLocpP>13GNVmW<8=R3_K%5Q9W*u~4upWe`4q(jqBTdcAw?ZG=v-jA5@FZ|^*5
zoU$NALGF+lEFssq<A{~zdHR7p&7+U(X~E!_yGM{l@40vQ%(~pazHH!+GB!sI;iCKZ
zY69Cjp-?V{LrnyMQ5I_>Rp5<1_i#FmdPY1z2tkYI|M1-7PdS}Ub_h8eK~m)?&(I;{
zd<2<NV1vyl7BWOggn_Hc5ba`wRu)R=x;oPiRuheYD}$9XJTpphG^wKX*mr|pw(;#T
zTvPxWb#R&-VC|~9KeFD0ooNCooO~P|@vNKL)n#t&WQm2JSh%gFRMuv7!M#yqYailx
z8TM&AUN~yqVM$ThVIE55OcVU4mW$eHC#dHEeUvCiE1wT#?U%cS^A_HAK$VqiIBG75
z($V`G!unJPuo@k2@gj4y7$WV7g73Ls@d32giPqc=`3mz^u|IR`05hOx29+=__XXIv
z%Xf#6<%P11b*dyatBVv$thED!=x%_Ts?sj1OY%b*t$Y}rODc$J2is^#<A~w+w`~mf
zCs_oC7u=9pAjzurLE}*e38}&1-KX^pd*7wM-Q35(VDtTJOgeOnB`K*rii#c_+)*qi
zNQ+5Dqv>MG0wcp<uf!}(SCXw)kqXk>xCSP@rQbRs58c`TmTbn>%WO@TFp;w*gB6RU
km;Ljlo8cvfMVVCc>`K4bOfE$-fO&T9$C>+RbV7Fh7t6}$ApigX

literal 0
HcmV?d00001


base-commit: 021ed9f551da33449a5238e45e849913422671d7
-- 
2.25.1.696.g5e7596f4ac-goog

