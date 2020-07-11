Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECBCC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9092E2076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgGKMjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:39:18 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:36456 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgGKMjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:39:17 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 0724DBC07E;
        Sat, 11 Jul 2020 12:39:14 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        grandmaster@al2klimov.de, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools: usb: usbip: Replace HTTP links with HTTPS ones
Date:   Sat, 11 Jul 2020 14:39:06 +0200
Message-Id: <20200711123906.16325-1-grandmaster@al2klimov.de>
In-Reply-To: <20200711062442.GA2784200@kroah.com>
References: <20200711062442.GA2784200@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Now better?

 tools/usb/usbip/vudc/vudc_server_example.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/usb/usbip/vudc/vudc_server_example.sh b/tools/usb/usbip/vudc/vudc_server_example.sh
index 2736be64f203..fed53f51ee01 100755
--- a/tools/usb/usbip/vudc/vudc_server_example.sh
+++ b/tools/usb/usbip/vudc/vudc_server_example.sh
@@ -24,7 +24,7 @@
 # ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 # OTHER DEALINGS IN THE SOFTWARE.
 #
-# For more information, please refer to <http://unlicense.org/>
+# For more information, please refer to <https://unlicense.org/>
 ################################################################################
 
 ################################################################################
-- 
2.27.0

