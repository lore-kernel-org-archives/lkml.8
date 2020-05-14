Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D99C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A0E2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgENJav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:30:51 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:39896 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725878AbgENJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:30:50 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 14 May 2020 18:30:45 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: changjoon.lee@lge.com
Received: from unknown (HELO MacBookPro.local.net) (10.157.161.30)
        by 156.147.1.125 with ESMTP; 14 May 2020 18:30:45 +0900
X-Original-SENDERIP: 10.157.161.30
X-Original-MAILFROM: changjoon.lee@lge.com
From:   changjoon.lee@lge.com
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux@endlessm.com,
        linux-kernel@vger.kernel.org, ChangJoon Lee <changjoon.lee@lge.com>
Subject: [PATCH v2 1/1] Updated negative return values for documentation update.
Date:   Thu, 14 May 2020 18:30:39 +0900
Message-Id: <20200514093039.39558-2-changjoon.lee@lge.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200514093039.39558-1-changjoon.lee@lge.com>
References: <20200514093039.39558-1-changjoon.lee@lge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChangJoon Lee <changjoon.lee@lge.com>

Hi, ALSA Teams,

This is documentation update purpose patch.
This patch does NOT alter any of operations.

This patch allows an application engineer to understand why they received negative return
such as -EIO, -EBADFD, -ENOSYS, -ESTRPIPE and etc which are not fully documented on documentation site.

This patch also exposes Expected Status of PCM based on bad_pcm_state() with P_STATE to help engineer to understand API behavior to the documentation site.

TODO :
We may need improve consistency of return value especially for snd_pcm_hw_params_current().
It returns -EBADFD when PCM is not setup while other API returns -EIO in this case.

Signed-off-by: ChangJoon Lee <changjoon.lee@lge.com>
---
 src/pcm/pcm.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 1064044c..b53797a6 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -820,6 +820,7 @@ int snd_pcm_nonblock(snd_pcm_t *pcm, int nonblock)
  * \param sig Signal to raise: < 0 disable, 0 default (SIGIO)
  * \param pid Process ID to signal: 0 current
  * \return 0 on success otherwise a negative error code
+ * \return -ENOSYS Async is not supported on this PCM
  *
  * A signal is raised every period.
  */
@@ -850,6 +851,7 @@ int snd_pcm_async(snd_pcm_t *pcm, int sig, pid_t pid)
  * \param pcm PCM handle
  * \param info Information container
  * \return 0 on success otherwise a negative error code
+ * \return -ENOSYS Info is not supported on this PCM
  */
 int snd_pcm_info(snd_pcm_t *pcm, snd_pcm_info_t *info)
 {
@@ -867,6 +869,7 @@ int snd_pcm_info(snd_pcm_t *pcm, snd_pcm_info_t *info)
  * \param pcm PCM handle
  * \param params Configuration space definition container
  * \return 0 on success otherwise a negative error code
+ * \return -EBADFD PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
  */
 int snd_pcm_hw_params_current(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 {
@@ -933,6 +936,7 @@ int snd_pcm_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 /** \brief Remove PCM hardware configuration and free associated resources
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
+ * \return -ENOSYS Hw_free is not supported on this PCM
  */
 int snd_pcm_hw_free(snd_pcm_t *pcm)
 {
@@ -960,7 +964,9 @@ int snd_pcm_hw_free(snd_pcm_t *pcm)
  * \param pcm PCM handle
  * \param params Configuration container
  * \return 0 on success otherwise a negative error code
- *
+ * \retval -EIO PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -EINVAL Incorrect parameter, avail_min cannot be 0
+ * 
  * The software parameters can be changed at any time.
  * The hardware parameters cannot be changed when the stream is
  * running (active).
@@ -1017,6 +1023,7 @@ int snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
  * \param pcm PCM handle
  * \param status Status container
  * \return 0 on success otherwise a negative error code
+ * \return -ENOSYS Status is not supported on this PCM
  *
  * The function is thread-safe when built with the proper option.
  */
@@ -1060,7 +1067,8 @@ snd_pcm_state_t snd_pcm_state(snd_pcm_t *pcm)
  * \brief (DEPRECATED) Synchronize stream position with hardware
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
- *
+ * \retval -EIO PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * 
  * Note this function does not update the actual r/w pointer
  * for applications. The function #snd_pcm_avail_update()
  * have to be called before any mmap begin+commit operation.
@@ -1089,6 +1097,7 @@ int snd_pcm_hwsync(snd_pcm_t *pcm)
  * \param pcm PCM handle
  * \param delayp Returned delay in frames
  * \return 0 on success otherwise a negative error code
+ * \retval -EIO PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
  *
  * For playback the delay is defined as the time that a frame that is written
  * to the PCM stream shortly after this call will take to be actually
@@ -1133,6 +1142,7 @@ int snd_pcm_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
  * \brief Resume from suspend, no samples are lost
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
+ * \retval -EIO    PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
  * \retval -EAGAIN resume can't be proceed immediately (audio hardware is probably still suspended)
  * \retval -ENOSYS hardware doesn't support this feature
  *
@@ -1166,6 +1176,8 @@ int snd_pcm_resume(snd_pcm_t *pcm)
  * \param avail Number of available frames when timestamp was grabbed
  * \param tstamp Hi-res timestamp
  * \return 0 on success otherwise a negative error code
+ * \retval -EIO    PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -ENOSYS Hi-res timestamp is not supported on this system.
  *
  * Note this function does not update the actual r/w pointer
  * for applications.
@@ -1194,6 +1206,9 @@ int snd_pcm_htimestamp(snd_pcm_t *pcm, snd_pcm_uframes_t *avail, snd_htimestamp_
  * \brief Prepare PCM for use
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
+ * \retval -EIO    PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -ENOSYS Prepare is not supported on this PCM
+ * \retval -EBADFD PCM is not in the right state (#SND_PCM_STATE_DISCONNECTED)
  *
  * The function is thread-safe when built with the proper option.
  */
@@ -1222,6 +1237,8 @@ int snd_pcm_prepare(snd_pcm_t *pcm)
  * \brief Reset PCM position
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
+ * \retval -EIO    PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -ENOSYS Reset is not supported on this PCM
  *
  * Reduce PCM delay to 0.
  *
@@ -1249,6 +1266,8 @@ int snd_pcm_reset(snd_pcm_t *pcm)
  * \brief Start a PCM
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
+ * \retval -EIO    PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -EBADFD PCM is not in the right state (#SND_PCM_STATE_PREPARED)
  *
  * The function is thread-safe when built with the proper option.
  */
@@ -1274,6 +1293,8 @@ int snd_pcm_start(snd_pcm_t *pcm)
  * \brief Stop a PCM dropping pending frames
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
+ * \retval -EIO    PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -EBADFD PCM is not in the right state (Should be PREPARED,RUNNING,XRUN,PAUSED,DRAINING,SETUP or SUSPENDED)
  *
  * This function stops the PCM <i>immediately</i>.
  * The pending samples on the buffer are ignored.
@@ -1309,7 +1330,10 @@ int snd_pcm_drop(snd_pcm_t *pcm)
  * \brief Stop a PCM preserving pending frames
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
+ * \retval -EIO    PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -EBADFD PCM is not in the right state (Should be PREPARED,RUNNING,XRUN,PAUSED or DRAINING,SETUP or SUSPENDED)
  * \retval -ESTRPIPE a suspend event occurred
+ * \retval -ENOSYS Drain is not supported on this PCM
  *
  * For playback wait for all pending frames to be played and then stop
  * the PCM.
@@ -1345,6 +1369,10 @@ int snd_pcm_drain(snd_pcm_t *pcm)
  * \param pcm PCM handle
  * \param enable 0 = resume, 1 = pause
  * \return 0 on success otherwise a negative error code
+ * \retval -EIO    PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -EBADFD PCM is not in the right state (Should be PREPARED,RUNNING,XRUN,PAUSED or DRAINING)
+ * \retval -ESTRPIPE a suspend event occurred
+ * \retval -ENOSYS Pause is not supported on this PCM
  *
  * Note that this function works only on the hardware which supports
  * pause feature.  You can check it via \link ::snd_pcm_hw_params_can_pause() \endlink
@@ -1377,6 +1405,10 @@ int snd_pcm_pause(snd_pcm_t *pcm, int enable)
  * \brief Get safe count of frames which can be rewinded
  * \param pcm PCM handle
  * \return a positive number of frames or negative error code
+ * \retval -EIO    PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -EBADFD PCM is not in the right state (Should be PREPARED,RUNNING,XRUN,PAUSED or DRAINING)
+ * \retval -ESTRPIPE a suspend event occurred
+ * \retval -ENOSYS Rewindable is not supported on this PCM
  *
  * Note: The snd_pcm_rewind() can accept bigger value than returned
  * by this function. But it is not guaranteed that output stream
@@ -1412,6 +1444,9 @@ snd_pcm_sframes_t snd_pcm_rewindable(snd_pcm_t *pcm)
  * \param frames wanted displacement in frames
  * \return a positive number for actual displacement otherwise a
  * negative error code
+ * \retval -EIO    PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -EBADFD PCM is not in the right state (Should be PREPARED,RUNNING,XRUN,PAUSED or DRAINING)
+ * \retval -ENOSYS Rewind is not supported on this PCM
  *
  * The function is thread-safe when built with the proper option.
  */
@@ -1443,6 +1478,9 @@ snd_pcm_sframes_t snd_pcm_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
  * \brief Get safe count of frames which can be forwarded
  * \param pcm PCM handle
  * \return a positive number of frames or negative error code
+ * \retval -EIO    PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -EBADFD PCM is not in the right state (Should be PREPARED,RUNNING,XRUN,PAUSED or DRAINING)
+ * \retval -ENOSYS Forwardable is not supported on this PCM
  *
  * Note: The snd_pcm_forward() can accept bigger value than returned
  * by this function. But it is not guaranteed that output stream
@@ -1478,6 +1516,9 @@ snd_pcm_sframes_t snd_pcm_forwardable(snd_pcm_t *pcm)
  * \param frames wanted skip in frames
  * \return a positive number for actual skip otherwise a negative error code
  * \retval 0 means no action
+ * \retval -EIO    PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -EBADFD PCM is not in the right state (Should be PREPARED,RUNNING,XRUN,PAUSED or DRAINING)
+ * \retval -ENOSYS Forward is not supported on this PCM
  *
  * The function is thread-safe when built with the proper option.
  */
@@ -1517,6 +1558,8 @@ use_default_symbol_version(__snd_pcm_forward, snd_pcm_forward, ALSA_0.9.0rc8);
  * \param size frames to be written
  * \return a positive number of frames actually written otherwise a
  * negative error code
+ * \retval -EIO    PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -EINVAL Access type is not Interleave type.
  * \retval -EBADFD PCM is not in the right state (#SND_PCM_STATE_PREPARED or #SND_PCM_STATE_RUNNING)
  * \retval -EPIPE an underrun occurred
  * \retval -ESTRPIPE a suspend event occurred (stream is suspended and waiting for an application recovery)
@@ -1556,6 +1599,8 @@ snd_pcm_sframes_t snd_pcm_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_ufr
  * \param size frames to be written
  * \return a positive number of frames actually written otherwise a
  * negative error code
+ * \retval -EIO    PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -EINVAL Access type is not Non-Interleave type.
  * \retval -EBADFD PCM is not in the right state (#SND_PCM_STATE_PREPARED or #SND_PCM_STATE_RUNNING)
  * \retval -EPIPE an underrun occurred
  * \retval -ESTRPIPE a suspend event occurred (stream is suspended and waiting for an application recovery)
@@ -1595,6 +1640,8 @@ snd_pcm_sframes_t snd_pcm_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t
  * \param size frames to be read
  * \return a positive number of frames actually read otherwise a
  * negative error code
+ * \retval -EIO PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -EINVAL Access type is not Interleave type.
  * \retval -EBADFD PCM is not in the right state (#SND_PCM_STATE_PREPARED or #SND_PCM_STATE_RUNNING)
  * \retval -EPIPE an overrun occurred
  * \retval -ESTRPIPE a suspend event occurred (stream is suspended and waiting for an application recovery)
@@ -1634,6 +1681,8 @@ snd_pcm_sframes_t snd_pcm_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t
  * \param size frames to be read
  * \return a positive number of frames actually read otherwise a
  * negative error code
+ * \retval -EIO PCM has not been setup (PCM isn't configured yet, or lifecycle of PCM has been ended)
+ * \retval -EINVAL Access type is not Non-Interleave type.
  * \retval -EBADFD PCM is not in the right state (#SND_PCM_STATE_PREPARED or #SND_PCM_STATE_RUNNING)
  * \retval -EPIPE an overrun occurred
  * \retval -ESTRPIPE a suspend event occurred (stream is suspended and waiting for an application recovery)
@@ -1669,8 +1718,9 @@ snd_pcm_sframes_t snd_pcm_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t s
 /**
  * \brief Link two PCMs
  * \param pcm1 first PCM handle
- * \param pcm2 first PCM handle
+ * \param pcm2 second PCM handle
  * \return 0 on success otherwise a negative error code
+ * \retval -ENOSYS Link is not supported on pcm1
  *
  * The two PCMs will start/stop/prepare in sync.
  */ 
@@ -1691,6 +1741,7 @@ int snd_pcm_link(snd_pcm_t *pcm1, snd_pcm_t *pcm2)
  * \brief Remove a PCM from a linked group
  * \param pcm PCM handle
  * \return 0 on success otherwise a negative error code
+ * \retval -ENOSYS Unlink is not supported on this PCM.
  */
 int snd_pcm_unlink(snd_pcm_t *pcm)
 {
-- 
2.26.2

