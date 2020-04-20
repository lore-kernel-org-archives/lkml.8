Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1330FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 04:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C013F221F7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 04:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgDTECi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 00:02:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2807 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725681AbgDTECh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 00:02:37 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 720B091CADBB50EFF986;
        Mon, 20 Apr 2020 12:02:36 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 12:02:29 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ASoC: wcd934x: remove unneeded semicolon
Date:   Mon, 20 Apr 2020 12:29:11 +0800
Message-ID: <20200420042911.19379-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

sound/soc/codecs/wcd934x.c:3621:2-3: Unneeded semicolon
sound/soc/codecs/wcd934x.c:4270:2-3: Unneeded semicolon
sound/soc/codecs/wcd934x.c:4018:2-3: Unneeded semicolon
sound/soc/codecs/wcd934x.c:4043:2-3: Unneeded semicolon
sound/soc/codecs/wcd934x.c:3804:2-3: Unneeded semicolon
sound/soc/codecs/wcd934x.c:3866:2-3: Unneeded semicolon
sound/soc/codecs/wcd934x.c:3596:2-3: Unneeded semicolon
sound/soc/codecs/wcd934x.c:3542:2-3: Unneeded semicolon
sound/soc/codecs/wcd934x.c:3673:2-3: Unneeded semicolon
sound/soc/codecs/wcd934x.c:3723:2-3: Unneeded semicolon
sound/soc/codecs/wcd934x.c:2492:2-3: Unneeded semicolon
sound/soc/codecs/wcd934x.c:1790:3-4: Unneeded semicolon
sound/soc/codecs/wcd934x.c:1806:3-4: Unneeded semicolon
sound/soc/codecs/wcd934x.c:1812:2-3: Unneeded semicolon

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 sound/soc/codecs/wcd934x.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 5269857e2746..a514eb32e3e6 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -1787,7 +1787,7 @@ static int wcd934x_hw_params(struct snd_pcm_substream *substream,
 				params_rate(params));
 			return -EINVAL;
 
-		};
+		}
 
 		ret = wcd934x_set_decimator_rate(dai, tx_fs_rate,
 						 params_rate(params));
@@ -1803,13 +1803,13 @@ static int wcd934x_hw_params(struct snd_pcm_substream *substream,
 			dev_err(wcd->dev, "Invalid format 0x%x\n",
 				params_width(params));
 			return -EINVAL;
-		};
+		}
 		break;
 	default:
 		dev_err(wcd->dev, "Invalid stream type %d\n",
 			substream->stream);
 		return -EINVAL;
-	};
+	}
 
 	wcd->dai[dai->id].sconfig.rate = params_rate(params);
 	wcd934x_slim_set_hw_params(wcd, &wcd->dai[dai->id], substream->stream);
@@ -2489,7 +2489,7 @@ static int wcd934x_compander_set(struct snd_kcontrol *kc,
 		break;
 	default:
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3539,7 +3539,7 @@ static int wcd934x_codec_enable_mix_path(struct snd_soc_dapm_widget *w,
 		val += offset_val;
 		snd_soc_component_write(comp, gain_reg, val);
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3593,7 +3593,7 @@ static int wcd934x_codec_enable_main_path(struct snd_soc_dapm_widget *w,
 		snd_soc_component_write(comp, gain_reg,
 				snd_soc_component_read32(comp, gain_reg));
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3618,7 +3618,7 @@ static int wcd934x_codec_ear_dac_event(struct snd_soc_dapm_widget *w,
 		wcd_clsh_ctrl_set_state(wcd->clsh_ctrl, WCD_CLSH_EVENT_POST_PA,
 					WCD_CLSH_STATE_EAR, CLS_H_NORMAL);
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3670,7 +3670,7 @@ static int wcd934x_codec_hphl_dac_event(struct snd_soc_dapm_widget *w,
 		break;
 	default:
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3720,7 +3720,7 @@ static int wcd934x_codec_hphr_dac_event(struct snd_soc_dapm_widget *w,
 		break;
 	default:
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3801,7 +3801,7 @@ static int wcd934x_codec_enable_hphl_pa(struct snd_soc_dapm_widget *w,
 		 */
 		usleep_range(20000, 20100);
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3863,7 +3863,7 @@ static int wcd934x_codec_enable_hphr_pa(struct snd_soc_dapm_widget *w,
 		 */
 		usleep_range(20000, 20100);
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -4015,7 +4015,7 @@ static int wcd934x_codec_enable_dmic(struct snd_soc_dapm_widget *w,
 		dev_err(comp->dev, "%s: Invalid DMIC Selection\n",
 			__func__);
 		return -EINVAL;
-	};
+	}
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -4040,7 +4040,7 @@ static int wcd934x_codec_enable_dmic(struct snd_soc_dapm_widget *w,
 			snd_soc_component_update_bits(comp, dmic_clk_reg,
 						      dmic_clk_en, 0);
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -4267,7 +4267,7 @@ static int wcd934x_codec_enable_dec(struct snd_soc_dapm_widget *w,
 					      WCD934X_DEC_PWR_LVL_MASK,
 					      WCD934X_DEC_PWR_LVL_DF);
 		break;
-	};
+	}
 out:
 	kfree(wname);
 	return ret;
-- 
2.21.1

