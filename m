Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D55FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E68206F8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4gZBwgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgCWTWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:22:44 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:47865 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgCWTWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:22:44 -0400
Received: by mail-qt1-f202.google.com with SMTP id x10so8299065qts.14
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=b3TV3f7zYOYzp4ZmIVYfuFFfeN9VG2wjzJh6wHfTV6M=;
        b=Z4gZBwgq+0xFcv8RckPi1qnCvoD6fHJ9ub3WqBdCfYmxwVZw6Al098BlY9VoLfDeyb
         iB0MObVc58HusOXUD+WGJ/PSDH0XDDSLEbxo4henXdLgWB/8UUE9zWAAT89Vuyi2djjL
         /cQCTumXtB8FYo+C56mvFbc0lxrOTQDK7RC9jeo5ie6zBfeke5chqh+VMrPZB+WBmTwu
         UDnf0IwepG6z5vPkRKLuPyqJH/Ob58jY+8QDvHTos0AFEvk2T9aT/tUvW3Q6mo3oOuTf
         DqKBGGoE7lCC0MOk0krMobiT5+VgB/EEBMbJq9tLqVp4JN8XIY1m93TVJ7o/rXEB+uz6
         cEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=b3TV3f7zYOYzp4ZmIVYfuFFfeN9VG2wjzJh6wHfTV6M=;
        b=ZDymLB9oi8+2xMHmmOs6gn1LrfLP6DjqCZ8lAHqpgk57KtwyeYtpW9c06R4m4r1AzV
         FuzBIVDNCp4KUH7Y4GVshauYyzIAdd+wQ+k+t7us7XBGG89vM+dQtNlAq61A8GLd/Xp2
         RVm7kiDpxTTso+jZ92N9qqPvJOHvLYDFoFmtHIPq+/3MSXRXC2va2kZpcGdUaW9J/oFE
         s5T5nH/PAZNDCGcIqEuiVZmF1+ptWxMvNXbUAF/Vxyr2IAahUfobZAGhpAf+jg6DXiMF
         bj0+QwNhFt7tVN5iKYZ+4z3OU1ROzKfD60+Qe2HSBm79BDmeFoCaTc70hXX7WtZtGt3T
         snJA==
X-Gm-Message-State: ANhLgQ0TsmvGWLZVg1zkpYHO3Xvii8kCJV7pu9IMKLKsRBbjYb707p53
        k5aTH10mlmNLhpyxS+Oz1+flGPyERI3ocethD6HLgg==
X-Google-Smtp-Source: ADFU+vvgMg/UiQ8gH1hyLSTrCyZfCEFnpnqU7yOsR0QRLbiAPWsqeftAb53ZTB58CKrBwku5M7vwhr+sQ0rR5ln7ZBlSQQ==
X-Received: by 2002:ad4:4dc5:: with SMTP id cw5mr22166003qvb.109.1584991363216;
 Mon, 23 Mar 2020 12:22:43 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:22:36 -0700
Message-Id: <20200323192236.70152-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2] kunit: tool: add missing test data file content
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

Add a missing raw dmesg test log to test the kunit_tool's dmesg parser.
test_prefix_poundsign and test_output_with_prefix_isolated_correctly
fail without this test log.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
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

