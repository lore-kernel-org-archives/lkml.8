Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D1FC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C932064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgD2TAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:00:02 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49127 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2TAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:00:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mn2Fb-1in8aH036d-00k7n6; Wed, 29 Apr 2020 20:59:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Julien Grall <julien.grall@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ubsan: fix gcc-10 warnings
Date:   Wed, 29 Apr 2020 20:59:35 +0200
Message-Id: <20200429185948.4189600-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HkxPfGnHYJGSk0C6wdDdnnj8OfDDTYNTZOo8toDKy6w2faWr+wz
 vnZUdy9xZqgWUr1lBvp3vQNAmfLg4VZYjGH+GDKOzf/L/hw58Cpho3X5MNU8jMoecOgps+a
 H+WISVPtr3XammZRdDBj9n+fIuqwGvQCnrkqR7XuzsegdgjLKS4rfvFmKCwogKGaLYk/ZcV
 b+tyvsE1/797+W/fL09NA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gfYI6kWzEM8=:9bL0pWPzk6T9hgKFHT8r7K
 QsCjGLelQqfeo3JIrmuuiZQKHv+vrsoFILUMIvx6I1gbRrWe00kZ5Lx0ylVKwkOdvaV8cxxgZ
 PUcj3ugsfFhDQTKar+fEdc2opD4AUf29sO3P6SZSVB7oDt4Y7NI2BMc0OTTsAhMSTe7XdHY+d
 qkWlKl7oHYJahlIpqwkDxTF3edQt2juOGJEFKgyWjd6qaa19lHnOFZ21jto26bF0Y3guZZ82z
 5R2b16gmraFgRjvHxGKnjZBR5LR97Gu6Kg1KsY4Z+7G+l1ys/+WwvcitceXOFNX9RXJEd5H88
 0v2H6djpdr95Al6kCBf2oB+8o5a79yqtq1Qy3ZCHlgKJPQXxTknj2lKpNx3ZgIap1bf3UUndn
 Rc/FX6Qb2xBLjudGIrbZMTmElos5efta06XKJg1T5NTYzZTGBP/aTZb0XwR80PmsJLG8AY/sl
 UDc5s1bA1Xle4MVf3mTJi/F6J9ijpCdTdM/gTM3vdb0QBUblHRgVVv4BXjcKh0ACGMyPLbFwi
 vkOmqAlbWs1Oh2TJB/u2aaCDuCTYGINqvpM9wNGR+hmdLree3uvImbISUgQhGSgHCdK7yK5DL
 fXlUwTwtOG0fIJ12z4jXcDF7dTaq12Lo3VhzI8QzlHBvMNZhA6bc6PRvnPFlvgzWAxcAaZGHD
 OD55Fsr10qctTFXqC/C2VWIhMCRD+B3eakBhcw84AqBwMMAhO9/HFR8F1bgPgw7gpNzc5918b
 1mw5l0L/x7ixgPwhiSwG+k1VbGWZ5gcT5xm8wvBcDXMwG+HEJBxQ7HUGS39KmEEvRSkq6g/ws
 8sQgyF41WAufYm6t2Nn8ugXiq3kw5lViQy+5PxRROJLrd31ofA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest compiler expects slightly different function prototypes
for the ubsan helpers:

lib/ubsan.c:192:6: error: conflicting types for built-in function '__ubsan_handle_add_overflow'; expected 'void(void *, void *, void *)' [-Werror=builtin-declaration-mismatch]
  192 | void __ubsan_handle_add_overflow(struct overflow_data *data,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/ubsan.c:200:6: error: conflicting types for built-in function '__ubsan_handle_sub_overflow'; expected 'void(void *, void *, void *)' [-Werror=builtin-declaration-mismatch]
  200 | void __ubsan_handle_sub_overflow(struct overflow_data *data,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/ubsan.c:207:6: error: conflicting types for built-in function '__ubsan_handle_mul_overflow'; expected 'void(void *, void *, void *)' [-Werror=builtin-declaration-mismatch]
  207 | void __ubsan_handle_mul_overflow(struct overflow_data *data,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/ubsan.c:214:6: error: conflicting types for built-in function '__ubsan_handle_negate_overflow'; expected 'void(void *, void *)' [-Werror=builtin-declaration-mismatch]
  214 | void __ubsan_handle_negate_overflow(struct overflow_data *data,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/ubsan.c:234:6: error: conflicting types for built-in function '__ubsan_handle_divrem_overflow'; expected 'void(void *, void *, void *)' [-Werror=builtin-declaration-mismatch]
  234 | void __ubsan_handle_divrem_overflow(struct overflow_data *data,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change the Linux implementation to match these, using a local
typed pointer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/ubsan.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index f8c0ccf35f29..cb9af3f6b77e 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -189,7 +189,7 @@ static void handle_overflow(struct overflow_data *data, void *lhs,
 	ubsan_epilogue();
 }
 
-void __ubsan_handle_add_overflow(struct overflow_data *data,
+void __ubsan_handle_add_overflow(void *data,
 				void *lhs, void *rhs)
 {
 
@@ -197,23 +197,23 @@ void __ubsan_handle_add_overflow(struct overflow_data *data,
 }
 EXPORT_SYMBOL(__ubsan_handle_add_overflow);
 
-void __ubsan_handle_sub_overflow(struct overflow_data *data,
+void __ubsan_handle_sub_overflow(void *data,
 				void *lhs, void *rhs)
 {
 	handle_overflow(data, lhs, rhs, '-');
 }
 EXPORT_SYMBOL(__ubsan_handle_sub_overflow);
 
-void __ubsan_handle_mul_overflow(struct overflow_data *data,
+void __ubsan_handle_mul_overflow(void *data,
 				void *lhs, void *rhs)
 {
 	handle_overflow(data, lhs, rhs, '*');
 }
 EXPORT_SYMBOL(__ubsan_handle_mul_overflow);
 
-void __ubsan_handle_negate_overflow(struct overflow_data *data,
-				void *old_val)
+void __ubsan_handle_negate_overflow(void *_data, void *old_val)
 {
+	struct overflow_data *data = _data;
 	char old_val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
@@ -231,9 +231,9 @@ void __ubsan_handle_negate_overflow(struct overflow_data *data,
 EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
 
 
-void __ubsan_handle_divrem_overflow(struct overflow_data *data,
-				void *lhs, void *rhs)
+void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
 {
+	struct overflow_data *data = _data;
 	char rhs_val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
@@ -326,10 +326,9 @@ void __ubsan_handle_type_mismatch(struct type_mismatch_data *data,
 }
 EXPORT_SYMBOL(__ubsan_handle_type_mismatch);
 
-void __ubsan_handle_type_mismatch_v1(struct type_mismatch_data_v1 *data,
-				void *ptr)
+void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr)
 {
-
+	struct type_mismatch_data_v1 *data = _data;
 	struct type_mismatch_data_common common_data = {
 		.location = &data->location,
 		.type = data->type,
@@ -341,8 +340,9 @@ void __ubsan_handle_type_mismatch_v1(struct type_mismatch_data_v1 *data,
 }
 EXPORT_SYMBOL(__ubsan_handle_type_mismatch_v1);
 
-void __ubsan_handle_out_of_bounds(struct out_of_bounds_data *data, void *index)
+void __ubsan_handle_out_of_bounds(void *_data, void *index)
 {
+	struct out_of_bounds_data *data = _data;
 	char index_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
@@ -357,9 +357,9 @@ void __ubsan_handle_out_of_bounds(struct out_of_bounds_data *data, void *index)
 }
 EXPORT_SYMBOL(__ubsan_handle_out_of_bounds);
 
-void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
-					void *lhs, void *rhs)
+void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs)
 {
+	struct shift_out_of_bounds_data *data = _data;
 	struct type_descriptor *rhs_type = data->rhs_type;
 	struct type_descriptor *lhs_type = data->lhs_type;
 	char rhs_str[VALUE_LENGTH];
@@ -399,8 +399,9 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 EXPORT_SYMBOL(__ubsan_handle_shift_out_of_bounds);
 
 
-void __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
+void __ubsan_handle_builtin_unreachable(void *_data)
 {
+	struct unreachable_data *data = _data;
 	ubsan_prologue(&data->location, "unreachable");
 	pr_err("calling __builtin_unreachable()\n");
 	ubsan_epilogue();
@@ -408,9 +409,9 @@ void __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
 }
 EXPORT_SYMBOL(__ubsan_handle_builtin_unreachable);
 
-void __ubsan_handle_load_invalid_value(struct invalid_value_data *data,
-				void *val)
+void __ubsan_handle_load_invalid_value(void *_data, void *val)
 {
+	struct invalid_value_data *data = _data;
 	char val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
-- 
2.26.0

